//
//  settingViewModel.swift
//  Recipe App
//
//  Created by Noah M on 2023-11-15.
//

import Foundation

class SettingViewModel: ObservableObject {
    @Published var searchResults: [RecipeResult] = []
    
    func performSearch(searchText: String) {
        NetworkService.shared.searchRecipes(query: searchText) { result in
            switch result {
            case.success(let recipes):
                DispatchQueue.main.async {
                    self.searchResults = recipes
                }
            case .failure(let error):
                print("Error Occurred During Search: \(error)")
            }
        }
    }
}


struct SearchResult: Codable{
   let results: [RecipeResult]
   let offset, number, totalResults: Int?
}

// MARK: - Result
struct RecipeResult: Codable {
   let id: Int?
   let title: String?
   let image: String?
   let imageType: ImageType?
}

enum ImageType: String, Codable {
   case jpg
}

