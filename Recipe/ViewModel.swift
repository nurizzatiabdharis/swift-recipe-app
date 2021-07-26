//
//  ViewModel.swift
//  Recipe
//
//  Created by Nur Izzati Binti Abd Haris on 24/07/2021.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipeList = [Recipe]()
    @Published var recipeType = [RecipeType]()
    
    init () {
        fetchRecipeList()
        fetchRecipeType()
    }
    
    func fetchRecipeList() {
        guard let url = URL(string: "https://gist.githubusercontent.com/nurizzatiabdharis/0fad98ccef357a864a059b29df4e10d8/raw/57bd0fd146cfee736368a28ebe8e3ff3fe03f329/recipe.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            DispatchQueue.main.async {
                self.recipeList = try! JSONDecoder().decode([Recipe].self, from: data!)
            }
        }.resume()
    }
    
    func fetchRecipeType() {
        guard let url = URL(string: "https://gist.githubusercontent.com/nurizzatiabdharis/bbc66cb9b0e6352355f6e421ea7c3938/raw/b10470b057a41917970452a6da115f7653fd4cf6/type.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            DispatchQueue.main.async {
                self.recipeType = try! JSONDecoder().decode([RecipeType].self, from: data!)
            }
        }.resume()
    }
    
    func addNewRecipe(recipe: Recipe) {
        let newRecipe = Recipe(
            id: "10\(recipeList.count+1)",
            title: recipe.title,
            image: recipe.image,
            type: recipe.type,
            rating: 4.9,
            reviews: 100,
            description: recipe.description,
            author: recipe.author,
            time: recipe.time,
            serving: recipe.serving,
            ingredients: recipe.ingredients,
            directions: recipe.directions)
        recipeList.append(newRecipe)
    }
    
    func editRecipe(recipe: Recipe) {
        let newRecipe = Recipe(
            id: recipe.id,
            title: recipe.title,
            image: recipe.image,
            type: recipe.type,
            rating: recipe.rating,
            reviews: recipe.reviews,
            description: recipe.description,
            author: recipe.author,
            time: recipe.time,
            serving: recipe.serving,
            ingredients: recipe.ingredients,
            directions: recipe.directions)
        
        recipeList.removeAll {
            $0.id == recipe.id
        }
        recipeList.append(newRecipe)
    }
}
