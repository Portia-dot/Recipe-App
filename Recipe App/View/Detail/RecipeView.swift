//
//  RecipeView.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-11.
//

import SwiftUI
import WebKit

struct RecipeView: View {
    
    enum Unit: String {
        case kcal = "kcal"
        case grams = "g"
    }
    
    @EnvironmentObject var favoriteModel: FavoritesViewModel
    @StateObject var viewModel = RecipeViewModel()
    let recipeID: Int
    @State private var isFavorite: Bool = false
    var body: some View {
        ScrollView{
            if let imageUrl = viewModel.selectedRecipe?.image,
               let url = URL(string: imageUrl){
                AsyncImage(url: url) {phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Image(systemName: "photo")
                            .iconModifier()
                    @unknown default:
                        EmptyView()
                    }
                    
                }
                .frame(height: 300)
                .background(LinearGradient(gradient: Gradient(colors: [Color (.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
            }
            
            if let recipe = viewModel.selectedRecipe {
                VStack(spacing: 10) {
                    Text(recipe.title ?? "Recipe")
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.green)
                    Text("Ready in \(recipe.readyInMinutes ?? 0) Minutes")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.gray)
                    
                    HStack(){
                        if let nutrients = viewModel.selectedRecipe?.nutrition?.nutrients,
                           let calories = nutrients.first(where: {$0.name == "Calories"}) {
                            Text("Meal Calories \(String(format: "%.2f", calories.amount ?? 0)) \(calories.unit?.rawValue ?? "kcal")")
                                    .font(.caption)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .font(.headline)
                                    .frame(width: UIScreen.main.bounds.width / 1 - 90, alignment: .leading)
                                    .bold()
                                                            
                        } else {
                            Text("Calories not available")
                        }
                        
                        
                        Divider()
                            .frame(height: 30)
                        
                        Button {
                            
                            let favoriteRecipe = FavoriteRecipe(id: recipeID, name: viewModel.selectedRecipe?.title ?? "Unknown", imageUrl: viewModel.selectedRecipe?.image ?? "")
                            
                                if favoriteModel.isFavorite(recipeId: recipeID){
                                    favoriteModel.removeFavorites(recipeId: recipeID)
                                }else {
                                    favoriteModel.addFavorite(recipe: favoriteRecipe)  
                                }
                                isFavorite = favoriteModel.isFavorite(recipeId: recipeID)
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(isFavorite ? .green : .gray)
                        }

                        
                    }
                    .padding()
                }
            }
            
            if let nutrients = viewModel.selectedRecipe?.nutrition?.nutrients{
                HStack(spacing: 30) {
                    if let fat = nutrients.first(where: { $0.name == "Fat" }) {
                        let roundedTotalDailyFat = viewModel.calculateTotalDailyRequirement(amount: fat.amount, percentOfDailyNeeds: fat.percentOfDailyNeeds)
                        StatisticView(name: "Fat", current: fat.amount ?? 0, goal: roundedTotalDailyFat)
                            .padding()
                    }
                    if let protein = nutrients.first(where: { $0.name == "Protein" }) {
                        let roundedTotalDailyProtein = viewModel.calculateTotalDailyRequirement(amount: protein.amount, percentOfDailyNeeds: protein.percentOfDailyNeeds)
                        StatisticView(name: "Protein", current: protein.amount ?? 0, goal: roundedTotalDailyProtein)
                            .padding()
                    }
                    if let carbs = nutrients.first(where: { $0.name == "Carbohydrates" }) {
                        let roundedTotalDailyCarbs = viewModel.calculateTotalDailyRequirement(amount: carbs.amount, percentOfDailyNeeds: carbs.percentOfDailyNeeds)
                        StatisticView(name: "carbs", current: carbs.amount ?? 0, goal: roundedTotalDailyCarbs)
                            .padding()
                    }
                    
                }
                .modifier(RecipeViewModel.CardBackground())
                .padding()
            }
            
            VStack{
                
                if let recipe = viewModel.selectedRecipe, let extendedIngredients = recipe.extendedIngredients {
                    
                    RecipeDetailsTab(
                        ingredients: extendedIngredients.map { $0.nameClean ?? "Unknown" },
                        instruction: recipe.instructions ?? "No Instructions"
                    )
                } else {
                    // Some placeholder or loading view.
                    Text("Loading...")
                }
                
                //                 RecipeDetailsTab(ingredients: viewModel.selectedRecipe?.extendedIngredients.map {$0.name} ?? ["Empty"], instruction: viewModel.selectedRecipe?.instructions ?? "No Instruction Provided")
            }
            .padding(.horizontal, 30)
            
        }
        .ignoresSafeArea(.container, edges: .top)
        .onAppear{
            viewModel.fetchRecipeDetails(recipeId: recipeID)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("Works")
                print("Fetched Recipe Details: \(String(describing: viewModel.selectedRecipe?.extendedIngredients))")
            }
        }
    }
    
    
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipeID: 642878)
    }
}


//CardModifier
extension Image{
    func iconModifier() -> some View{
        self
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100, alignment: .center)
            .foregroundColor(.white.opacity(0.7))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

