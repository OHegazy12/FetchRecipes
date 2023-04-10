//
//  CategoryViewModel.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/8/23.
//

import Foundation

final class CategoryViewModel: ObservableObject
{
    private var network: Networking
    
    // List of categories that will be fetched from the API and displayed in the UI
    @Published var categories: [Category] = []
    
    init(networking: Networking)
    {
        network = networking
    }
    
    // Fetches categories from the API and updates the "categories" property.
    func fetchCategories()
    {
        network.fetch(CategoryEndpoint())
        { [self] (result: Result<CategoriesResponse, APIError>) in
            
            DispatchQueue.main.async
            { [self] in
                switch result
                {
                    // If the API call is successful, update the "categories" property with the fetched data.
                    case .success(let categories):
                        self.categories = categories.categories
                    
                    // If the API call fails, log the error message to the console.
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
}

// API endpoint for fetching categories.
struct CategoryEndpoint: APIResource
{
    var path: String
    {
        return "/api/json/v1/1/categories.php"
    }
}
