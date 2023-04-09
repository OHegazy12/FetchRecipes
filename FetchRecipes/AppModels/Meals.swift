//
//  Meals.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/9/23.
//

import Foundation

struct Meals: Codable
{
    let meals: [Meal]
}

struct Meal: Codable, Identifiable, Hashable
{
    let id: String = UUID().uuidString
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    enum CodingKeys: String, CodingKey
    {
        case id, strMeal, strMealThumb, idMeal
    }
}
