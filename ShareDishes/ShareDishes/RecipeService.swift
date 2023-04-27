//
//  RecipeService.swift
//  ShareDishes
//
//  Created by Polina Smirnova on 07.04.2023.
//

import Foundation

class RecipeService {
    let apiKey = "99dd345873b042c7a25802013692062d"
    
    func searchRecipes(query: String, completion: @escaping ([Recipe]) -> ()) {
        // Build the API endpoint URL with the given query and API key
        guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=\(apiKey)&query=\(query)") else {
            completion([])
            return
        }
        
        // Fetch the data from the API endpoint URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            // Decode the JSON data into an array of RecipeResult objects
            do {
                let searchResponse = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
                let recipes = searchResponse.results.map { Recipe(id: $0.id, title: $0.title, imageURL: $0.image) }
                completion(recipes)
            } catch {
                completion([])
            }
        }.resume()
    }
}

struct RecipeSearchResponse: Codable {
    let results: [RecipeResult]
}

struct RecipeResult: Codable {
    let id: Int
    let title: String
    let image: String
}

