//
//  FoodViewModel.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/9/23.
//

import Foundation

final class FoodViewModel: ObservableObject
{
    // Declares a networking object to make API requests
    private var network: Networking
    
    // Initializes the class by providing a networking object
    init(networking: Networking)
    {
        network = networking
    }
    
    // Declares an array of meals as @Published to update the view automatically
    @Published var meals: [Meal] = []
    
    // Method to fetch meals using a specific category name
    func fetchFoods(name: String)
    {
        // Make an API request using the Networking object
        network.fetch(FilterEndpoint(name: name))
        { [self] (result: Result<Meals, APIError>) in
            DispatchQueue.main.async
            { [self] in
                // Handles the API response accordingly
                switch result
                {
                    case .success(let categories):
                        // Set the array of meals with the data returned from the API
                        self.meals = categories.meals
                    case .failure(let error):
                        // Logs the error to the console
                        print(error.localizedDescription)
                }
            }
        }
    }
}


// Defines the endpoint for the API request
struct FilterEndpoint: APIResource
{
    // Declares an optional category name variable
    var name: String?
    
    // Defines the path for the API request using the category name variable
    var path: String
    {
        guard let name = name else
        {
            preconditionFailure("name is required")
        }
        return "/api/json/v1/1/filter.php?c=\(name)"
    }
}
