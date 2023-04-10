//
//  CategoriesView.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/7/23.
//

import SwiftUI

struct CategoryView: View
{
    @ObservedObject var viewModel: CategoryViewModel
    var foodVm = FoodViewModel(networking: Network())
    let gridItem = [GridItem(.fixed(170), spacing: 20),GridItem(.fixed(170), spacing: 20)]
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                Color(hex: 0x1A1E21).edgesIgnoringSafeArea(.all)
                ScrollView
                {
                    LazyVGrid(columns: gridItem)
                    {
                        ForEach(viewModel.categories, id: \.self)
                        { category in
                          NavigationLink(destination: FoodsGridView(name: category.name, viewModel: foodVm))
                            {
                                CategoryCell(imageURL: category.imageURL, name: category.name, sizing: 110)
                            }
                        }
                    }
                }
            }
            
            .onAppear(perform: viewModel.fetchCategories)
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
        }
            .accentColor(.white)
    }
}
