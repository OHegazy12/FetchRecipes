//
//  MockAPIService.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/9/23.
//

import Foundation

class MockAPIService: Networking // Mock Test for API
{
    // Fetches mock data from a JSON string
    func fetch<T>(jsonString: String, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable
    {
        let jsonData = jsonString.data(using: .utf8)! // Converts the JSON string into data
        do
        {
            let decoder = JSONDecoder() // Create a JSON decoder instance
            let decodedResponse = try decoder.decode(T.self, from: jsonData) // Decodes the JSON data into the requested type
            completion(.success(decodedResponse)) // Passes the decoded data to the completion handler as a success
        }
        catch
        {
            print(String(describing: error))
            completion(.failure(.invalidData)) // If an error occurs during decoding, pass an invalid data error to the completion handler
        }
    }
}
