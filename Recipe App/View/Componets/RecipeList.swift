//
//  RecipeList.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-11.
//

import SwiftUI

struct RecipeList: View {
    var recipes : [Recipe]
    var body: some View {
        VStack{
            HStack {
                Text("\(recipes.count) \(recipes.count > 1 ? "Recipes": "Recipe")")
                    .font(.headline)
                    .fontWeight(.medium)
                .opacity(0.7)
                Spacer()
    
            }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 15)]) {
                ForEach(recipes, id: \.id) { recipe in
                    RecipeCard(recipe: recipe)
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
    }
}


//struct RecipeList_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollView{
//            RecipeList(recipes: PreviewRecipe.all.map{ Recipe($0)})
//        }
//    }
//}
//
//
//
//extension PreviewRecipe {
//    static var all: [PreviewRecipe] {
//        [
//            PreviewRecipe(
//                id: 633078,
//                title: "Authentic Italian Biscotti",
//                readyInMinutes: 45,
//                servings: 60,
//                sourceUrl: "http://www.foodista.com/recipe/7LQFSKC5/authentic-italian-biscotti",
//                image: "https://spoonacular.com/recipeImages/633078-556x370.jpg",
//                summary: "You can never have too many Mediterranean recipes...",
//                cuisines: ["Mediterranean", "Italian", "European"]
//            ),
//            PreviewRecipe(
//                id: 6330782,
//                title: "Authentic Italian Biscotti",
//                readyInMinutes: 45,
//                servings: 60,
//                sourceUrl: "http://www.foodista.com/recipe/7LQFSKC5/authentic-italian-biscotti",
//                image: "https://spoonacular.com/recipeImages/633078-556x370.jpg",
//                summary: "You can never have too many Mediterranean recipes...",
//                cuisines: ["Mediterranean", "Italian", "European"]
//            ),
//            PreviewRecipe(
//                id: 6330783,
//                title: "Authentic Italian Biscotti",
//                readyInMinutes: 45,
//                servings: 60,
//                sourceUrl: "http://www.foodista.com/recipe/7LQFSKC5/authentic-italian-biscotti",
//                image: "https://spoonacular.com/recipeImages/633078-556x370.jpg",
//                summary: "You can never have too many Mediterranean recipes...",
//                cuisines: ["Mediterranean", "Italian", "European"]
//            ),
//            PreviewRecipe(
//                id: 6330784,
//                title: "Authentic Italian Biscotti",
//                readyInMinutes: 45,
//                servings: 60,
//                sourceUrl: "http://www.foodista.com/recipe/7LQFSKC5/authentic-italian-biscotti",
//                image: "https://spoonacular.com/recipeImages/633078-556x370.jpg",
//                summary: "You can never have too many Mediterranean recipes...",
//                cuisines: ["Mediterranean", "Italian", "European"]
//            ),
//            PreviewRecipe(
//                id: 6330785,
//                title: "Authentic Italian Biscotti",
//                readyInMinutes: 45,
//                servings: 60,
//                sourceUrl: "http://www.foodista.com/recipe/7LQFSKC5/authentic-italian-biscotti",
//                image: "https://spoonacular.com/recipeImages/633078-556x370.jpg",
//                summary: "You can never have too many Mediterranean recipes...",
//                cuisines: ["Mediterranean", "Italian", "European"]
//            ),
//        ]
//    }
//}
//
//extension Recipe {
//    init(_ preview: PreviewRecipe) {
//        self.id = preview.id
//        self.title = preview.title
//        self.readyInMinutes = preview.readyInMinutes
//        self.servings = preview.servings
//        self.sourceURL = preview.sourceUrl
//        self.image = preview.image
//        self.summary = preview.summary
//        self.cuisines = preview.cuisines
//        self.vegetarian = false 
//        self.vegan = false
//    }
//}
//
