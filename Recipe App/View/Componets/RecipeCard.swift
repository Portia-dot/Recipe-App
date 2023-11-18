//
//  RecipeCard.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-11.
//

import SwiftUI
 

struct RecipeCard: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            if let imageUrl = recipe.image,
               let url = URL(string: imageUrl){
                AsyncImage(url: url) {phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .overlay(alignment: .bottom) {
                                Text(recipe.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 3, x:0, y:0)
                                    .frame(maxWidth: 136)
                                    .padding()
                                
                            }
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(.white.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(alignment: .bottom) {
                                Text(recipe.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 3, x:0, y:0)
                                    .frame(maxWidth: 136)
                                    .padding()
                                
                            }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 160, height: 217, alignment: .top)
                .background(LinearGradient(gradient: Gradient(colors: [Color (.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y:10)
            }
            
        }
    }
}

//struct PreviewRecipe {
//    let id: Int
//    let title: String
//    let readyInMinutes: Int
//    let servings: Int
//    let sourceUrl: String
//    let image: String
//    let summary: String
//    let cuisines: [String]
//}
//
//
//struct RecipeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockRecipe = Recipe(PreviewRecipe(
//            id: 633078,
//            title: "Authentic Italian Biscotti",
//            readyInMinutes: 45,
//            servings: 60,
//            sourceUrl: "http://www.foodista.com/recipe/7LQFSKC5/authentic-italian-biscotti",
//            image: "https://spoonacular.com/recipeImages/633078-556x370.jpg",
//            summary: "You can never have too many Mediterranean recipes...",
//            cuisines: ["Mediterranean", "Italian", "European"]
//        ))
//        RecipeCard(recipe: mockRecipe)
//    }
//}
//
//
//
