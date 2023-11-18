//
//  SearchView.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-10.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SettingViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack(){
//                TextField("Search Recipes", text: $searchText)
//                    .padding()
//                    .border(.green, width: 1)
//                    .padding()
//
//                Button("Search") {
//                    viewModel.performSearch(searchText: searchText)
//                }
//                .padding()
//                .bold()
//                .foregroundColor(.green)
                
                
                
                List(viewModel.searchResults, id: \.id) { result in
                    if let id = result.id, let title = result.title {
                        NavigationLink(destination: RecipeView(recipeID: id)) {
                            AsyncImage(url: URL(string: result.image ?? "unknown")) {phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .frame(width: 44, height: 44)
                                case .failure:
                                    Image(systemName: "photo")
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.green, lineWidth: 2))
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            Text(title)
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                    }
                }
            }
            .navigationTitle("Recipe Search")
            .searchable(text: $searchText, prompt: "Search With Recipe Name Or Ingredients")
            .onChange(of: searchText) { newValue in
                viewModel.performSearch(searchText: newValue)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
