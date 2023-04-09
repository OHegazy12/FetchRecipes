//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Omar Hegazy on 04/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    var categoryVM = CategoryViewModel(networking: Network())
    var body: some View {
        CategoryView(viewModel: categoryVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
