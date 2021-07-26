//
//  Search.swift
//  Recipe
//
//  Created by Nur Izzati Binti Abd Haris on 23/07/2021.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var recipesVM : RecipeViewModel
    @State private var query: String = ""
    @State private var selectedType: String = "All"
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Search recipe by name", text: $query)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.query = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.query = ""
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(recipesVM.recipeType) { type in
                        Button(action: {
                            self.selectedType = type.label
                        }, label: {
                            Text(type.label)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                                .cornerRadius(15)
                                .background(self.selectedType == type.label ? Color.orange : Color.white)
                                .cornerRadius(15)
                                .foregroundColor(self.selectedType == type.label ? Color.white : Color.black)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.orange, lineWidth: 2))
                        })
                    }
                }.frame(height: 50)
                .padding(.horizontal, 10)
            }
            ScrollView(.vertical, showsIndicators: false){
                ForEach(searchResults) { recipe in
                    if(self.selectedType == "All") {
                        RecipeCardSmall(recipe: recipe, recipesVM: recipesVM)
                            .padding(.trailing)
                            .padding(.vertical, 5)
                    } else {
                        if (recipe.type == self.selectedType) {
                            RecipeCardSmall(recipe: recipe, recipesVM: recipesVM)
                                .padding(.trailing)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }.padding(.leading)
            Spacer()
        }.navigationBarTitle("Search Recipe")
    }
    
    var searchResults: [Recipe] {
            if query.isEmpty {
                return recipesVM.recipeList
            } else {
                return recipesVM.recipeList.filter { $0.title.lowercased().contains(query.lowercased()) }
            }
    }
}
