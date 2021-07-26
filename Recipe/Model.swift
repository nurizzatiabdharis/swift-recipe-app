//
//  Model.swift
//  Recipe
//
//  Created by Nur Izzati Binti Abd Haris on 24/07/2021.
//

import Foundation

struct Recipe: Identifiable, Decodable {
    var id: String
    var title: String
    var image: String
    var type: String
    var rating: Float
    var reviews: Int
    var description: String
    var author: String
    var time: Int
    var serving: Int
    var ingredients: [String]
    var directions: [String]
}

struct RecipeType: Identifiable, Decodable, Hashable {
    var id: String
    var label: String
}
