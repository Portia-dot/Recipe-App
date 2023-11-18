//
//NetworkService.swift
//  Recipe App
//
//  Created by Oluwayomi M on 2023-11-10.
//

import Foundation

enum NetworkError: Error{
    case urlError
    case decodingError
    case serverError(String)
    case apiLimitReached(String)
}

struct ApiErrorResponse: Codable {
    let status: String
    let code: Int
    let message: String
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
   private var apiKey = "213125028add4d5380cf18b6cc86fdec"
//     private var apiKey = "37836ece928942c9ac4389e4d06cbc83"
    
//    @State private var searchText: String = ""
    
    func fetchRandomRecipe(completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/random?number=20&tags=vegetarian,dessert&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                if let data = data, let apiError = try? JSONDecoder().decode(ApiErrorResponse.self, from: data) {
                    completion(.failure(.apiLimitReached(apiError.message)))
                } else {
                    completion(.failure(.urlError))
                }
                return
            }

            guard let data = data else {
                completion(.failure(.urlError))
                return
            }

            do {
                let response = try JSONDecoder().decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.recipes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchByMealType(mealType: String, completion: @escaping (Result<[Recipe], NetworkError>) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/random?number=20&tags=\(mealType)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error  = error {
                completion(.failure(.serverError(error.localizedDescription)))
            }
            guard let data = data else {
                completion(.failure(.urlError))
                return
            }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.recipes))
//                    print(response.recipes)
                }
            }catch {
                print("Decoding Error: \(error)")
//                DispatchQueue.main.async {
//                    completion(.failure(.decodingError(error.localizedDescription)))
//                }
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchRecipeDetails(recipeId: Int, completion: @escaping (Result<Nutrition, NetworkError>) -> Void) {
            let urlString = "https://api.spoonacular.com/recipes/\(recipeId)/information?includeNutrition=true&apiKey=\(apiKey)"
            guard let url = URL(string: urlString) else {
                completion(.failure(.urlError))
                return
            }
        print("URL being accessed: \(url.absoluteString)")
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(.serverError(error.localizedDescription)))
                    }
                    return
                }
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.urlError))
                    }
                    return
                }
                do {
                    let response = try JSONDecoder().decode(Nutrition.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            }.resume()
        }

    func searchRecipes(query: String, completion: @escaping (Result<[RecipeResult], NetworkError>) -> Void) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(query)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                if let data = data, let apiError = try? JSONDecoder().decode(ApiErrorResponse.self, from: data) {
                    completion(.failure(.apiLimitReached(apiError.message)))
                } else {
                    completion(.failure(.urlError))
                }
                return
            }

            guard let data = data else {
                completion(.failure(.urlError))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(SearchResult.self, from: data)
                // Use results here within the same scope
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }

}
