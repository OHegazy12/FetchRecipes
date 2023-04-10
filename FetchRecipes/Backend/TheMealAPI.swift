//
//  TheMealAPI.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/9/23.
//

import Foundation

// Protocol to define the properties of an API resource
protocol APIResource
{
    var scheme: String { get }   // URL scheme (http/https)
    var path: String { get }     // Path to the resource
    var host: String { get }     // API hostname
}

// Default implementation of APIResource properties
extension APIResource
{
    var scheme: String
    {
        return "https"     // Use https by default
    }
    var host: String
    {
        return "themealdb.com"  // Use TheMealDB API hostname by default
    }
}

// Protocol to define networking behavior for fetching data
protocol Networking
{
    // Fetch function takes a generic type parameter T that conforms to Decodable
    func fetch<T: Decodable>(_ endpoint: APIResource, completion: @escaping (Result<T, APIError>) -> Void)
}

// Default implementation of the fetch function
extension Networking
{
    func fetch<T: Decodable>(_ endpoint: APIResource, completion: @escaping (Result<T, APIError>) -> Void)
    {
        // Constructs the URL from endpoint properties
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        // Makes sure the URL is valid
        guard let urlString = urlComponents.url?.description else
        {
            preconditionFailure("Url is not valid")
        }
        guard let url = URL(string: urlString.removingPercentEncoding!) else
        {
            preconditionFailure("Url is not valid")
        }
        
        // Creates a data task to fetch data from the API
        let task = URLSession.shared.dataTask(with: URLRequest(url: url))
        { data, response, error in
            if let _ =  error
            {
                completion(.failure(.unableToComplete))
                return
            }
            
            // Check if the response is valid (status code 200)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else
            {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Check if data was returned by the API
            guard let data = data else
            {
                completion(.failure(.invalidData))
                return
            }
            
            // Parse data based on endpoint type (lookup vs. other endpoints)
            if endpoint.path.contains("lookup")
            {
                do
                {
                    // Parse the JSON data using the formatResponse function
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    guard let json = json else
                    {
                        preconditionFailure("Not good json")
                    }
                    completion(.success(formatResponse(unparsedData: json) as! T))
                }
                
                catch
                {
                    print(String(describing: error))
                    completion(.failure(.invalidData))
                }
            }
            
            else
            {
                do
                {
                    // Decode the JSON data using the JSONDecoder
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch
                {
                    print(String(describing: error))
                    completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
}

struct Network: Networking {}

enum Paths: String
{
    case lookup = "lookup.php?i="
    case categories = "categories.php"
    case filter = "filter.php?c="
}

enum APIError: Error
{
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
