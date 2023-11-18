// FavoriteView.swift
import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favoriteViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(favoriteViewModel.favoriteRecipes) { favoriteRecipe in
                        HStack(spacing: 10) {
                            NavigationLink(destination: RecipeView(recipeID: favoriteRecipe.id)) {
                                HStack {
                                    if let url = URL(string: favoriteRecipe.imageUrl) {
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.green, lineWidth: 2))
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.green, lineWidth: 2))
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        .frame(width: 50, height: 50)
                                    }
                                    Text(favoriteRecipe.name)
                                        .padding(.leading, 10)
                                        .foregroundColor(.green)
                                        .font(.caption)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())

                            Spacer()

                            Button(action: {
                                favoriteViewModel.removeFavorites(recipeId: favoriteRecipe.id)
                            }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.green)
                                    .imageScale(.large)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(FavoritesViewModel())
    }
}

