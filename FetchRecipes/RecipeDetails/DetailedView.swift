//
//  DetailedView.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 4/7/23.
//

import SwiftUI
import CachedAsyncImage

struct DetailedView: View
{
    var dessertId: String
    var imageUrl: String
    @State var selectedCategory = "Ingredients" // Defaults selected category to "Ingredients"
    @ObservedObject var detailViewModel: RecipeCard // Displays recipe details in RecipeCard format
    
    var body: some View
    {
        ZStack
        {
            Color(hex: 0x1A1E21).edgesIgnoringSafeArea(.all) // background color
            ScrollView
            {
                VStack(alignment: .center)
                {
                    Text("\(detailViewModel.recipe.name)") // Displays Recipe name
                        .font(.system(size: 24, weight: .medium,design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom)
                    
                    CachedAsyncImage(url: URL(string: imageUrl), transaction: .init(animation: .spring(response: 1.6))) // Cached async image view with URL and animation transaction
                    { phase in
                        switch phase
                        {
                            case .empty: // Image not yet loaded
                                ProgressView()
                                    .progressViewStyle(.circular)
                            case .success(let image): // Image loaded successfully
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure: // Failed to fetch image
                                Text("Failed fetching image. Make sure to check your data connection and try again.")
                                    .foregroundColor(.red)
                            @unknown default: // Unknown error
                                Text("Unknown error. Please try again.")
                                    .foregroundColor(.red)
                        }
                    }
                    .frame(width: 300, height: 300) // Image view size
                    .cornerRadius(10) // Image view corner radius
                    
                    PickerView(selectedCategory: $selectedCategory,labels:  ["Ingredients","Instructions"]) // Uses PickerView to allow user to switch between Ingredients & Instructions
                    
                    if selectedCategory == "Instructions" // Show instructions if selected
                    {
                        InstructionsStack(instructions: (detailViewModel.recipe.instructions!))
                    }
                    
                    if selectedCategory == "Ingredients" // Show ingredients if selected
                    {
                        IngredientsStack(ingredients: (detailViewModel.recipe.ingredients!))
                    }
                    
                    Spacer() // push content to the top of the view
                }
                .onAppear() // Fetch recipe details when the view appears
                {
                    detailViewModel.fetchDetails(id: dessertId)
                }
            }
        }
    }
}
