//
//  RecipeViewModel.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-10.
//
import SwiftUI
import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedRecipe: Nutrition?
    
    func fetchRandomRecipe() {
        isLoading = true
        NetworkService.shared.fetchRandomRecipe { [weak self ] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedRecipes):
                    self?.recipes = fetchedRecipes
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    func fetchRecipes(for mealType: MealType) {
        let selectedType = mealType == .randomRecipe ? MealType.allCases.filter { $0 != .randomRecipe }.randomElement() ?? .mainCourse : mealType
        isLoading = true
        NetworkService.shared.fetchByMealType(mealType: selectedType.rawValue) {[weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let fetchedRecipes):
                    self?.recipes = fetchedRecipes
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchRecipeDetails(recipeId: Int){
        isLoading = true
        NetworkService.shared.fetchRecipeDetails(recipeId: recipeId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let recipeDetails):
                    self?.selectedRecipe = recipeDetails
                    print("Fetched recipe details: \(String(describing: self?.selectedRecipe))")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching recipe details: \(error.localizedDescription)")
                }
            }
        }
            }
        
        enum MealType: String, CaseIterable, Identifiable {
            case mainCourse = "main course"
            case sideDish = "side dish"
            case dessert
            case appetizer
            case salad
            case bread
            case breakfast
            case soup
            case beverage
            case sauce
            case marinade
            case fingerfood
            case snack
            case drink
            case randomRecipe = "Random Recipe"
            
            var id: String { self.rawValue }
        }
        
        
    struct CardBackground: ViewModifier{
        func body(content: Content) -> some View {
            content
                .background()
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 4)
        }
    }


    func calculateTotalDailyRequirement(amount: Double?, percentOfDailyNeeds: Double?) -> Double {
        let total = (amount ?? 0) / (percentOfDailyNeeds ?? 0) * 100
        return (total * 10).rounded() / 10
    }



    }


