//
//  HomeView.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-10.
//

import SwiftUI



struct HomeView: View {
    @StateObject var viewModel = RecipeViewModel()
    @State private var selectedMealType: RecipeViewModel.MealType = .marinade
    @State private var showPicker = false
    @State private var showAlert = false
    @State private var isInitialDataLoaded = false
    var body: some View {
        NavigationView {
            VStack {
                Button("Select Meal Type"){
                    showPicker.toggle()
                }
//                if viewModel.isLoading {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle())
//                        .scaleEffect(2)
//                }else {
                    ScrollView {

                            ForEach(viewModel.recipes, id: \.id) { recipe in
                                NavigationLink(destination: RecipeView(recipeID: recipe.id)) {
                                    RecipeList(recipes: viewModel.recipes)
                                }
                            }
                        
                    }
                    .navigationTitle("Home")
                    .foregroundColor(.green)
                    .onAppear{
                        if !isInitialDataLoaded{
                            viewModel.fetchRandomRecipe()
                            isInitialDataLoaded = true
                        }
                    }
                    .onChange(of: selectedMealType) { newValue in
                        viewModel.fetchRecipes(for: newValue)
                    }
                
//                /}

            }
            .sheet(isPresented: $showPicker) {
                RecipePicker(selectedMealType: $selectedMealType, isPresented: $showPicker)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown Error"), dismissButton: .default(Text("Ok")))
            }
            .onReceive(viewModel.$errorMessage) { errorMessage in
                showAlert = errorMessage != nil
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
