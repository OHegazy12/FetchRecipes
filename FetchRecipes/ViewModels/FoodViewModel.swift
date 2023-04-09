//
//  FoodViewModel.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 04/07/2023.
//

import Foundation

final class FoodViewModel: ObservableObject
{
    private var network: Networking
    init(networking: Networking)
    {
        network = networking
    }
    
    @Published var meals: [Meal] = []
    func fetchFoods(name: String)
    {
        network.fetch(FilterEndpoint(name: name)) { [self] (result: Result<Meals, APIError>) in
            DispatchQueue.main.async
            { [self] in
                switch result
                {
                    case .success(let categories):
                        self.meals = categories.meals
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
}


struct FilterEndpoint: APIResource
{
    var name: String?
    var path: String
    {
        guard let name = name else
        {
            preconditionFailure("name is required")
        }
        return "/api/json/v1/1/filter.php?c=\(name)"
    }
}
