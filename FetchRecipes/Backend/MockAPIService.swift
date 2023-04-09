//
//  MockAPIService.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/9/23.
//

import Foundation

class MockAPIService: Networking
{
    func fetch<T>(jsonString: String, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable
    {
        let jsonData = jsonString.data(using: .utf8)!
        do
        {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(T.self, from: jsonData)
            completion(.success(decodedResponse))
        } catch
        {
            print(String(describing: error))
            completion(.failure(.invalidData))
        }
    }
}
