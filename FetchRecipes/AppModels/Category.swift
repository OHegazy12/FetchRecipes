//
//  Category.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/9/23.
//

import Foundation

struct Category: Codable, Hashable
{
    let name: String
    let imageURL: String
    enum CodingKeys: String, CodingKey
    {
        case name = "strCategory"
        case imageURL = "strCategoryThumb"
    }
}

struct CategoriesResponse: Codable
{
    let categories: [Category]
}
