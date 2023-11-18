//
//  FavoritesViewModel.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-15.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoriteRecipes: [FavoriteRecipe] = []
    
    func addFavorite(recipe: FavoriteRecipe){
        if !favoriteRecipes.contains(where:{ $0.id == recipe.id}){
            favoriteRecipes.append(recipe)
        }
    }
    
    func removeFavorites(recipeId: Int){
        favoriteRecipes.removeAll{$0.id == recipeId}
    }
    func isFavorite(recipeId: Int) -> Bool {
        favoriteRecipes.contains { $0.id == recipeId }
    }
}

struct FavoriteRecipe: Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
}
