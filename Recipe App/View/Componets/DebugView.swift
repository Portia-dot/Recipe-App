//
//  ShowPicker.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-11.
//

import SwiftUI

struct DebugView: View {
    @StateObject var viewModel = RecipeViewModel()
    let recipeID: Int

    var body: some View {
        ScrollView {
            // Existing code...

            // Debugging view
            if let extendedIngredients = viewModel.selectedRecipe?.extendedIngredients {
                VStack(alignment: .leading) {
                    Text("Debugging Extended Ingredients:")
                        .font(.headline)
                        .padding(.top)
                    ForEach(extendedIngredients, id: \.id) { ingredient in
                        if let name = ingredient.name {
                            Text("Name: \(name)")
                        } else {
                            Text("Name not available")
                        }
                        if let nameClean = ingredient.nameClean {
                            Text("Clean Name: \(nameClean)")
                        } else {
                            Text("Clean Name not available")
                        }
                    }
                }
            } else {
                Text("No extended ingredients available")
            }

            // Rest of your code...
        }
        .onAppear {
            viewModel.fetchRecipeDetails(recipeId: recipeID)
        }
    }
}


struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView(recipeID: 642878)
    }
}
