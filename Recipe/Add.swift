//
//  Add.swift
//  Recipe
//
//  Created by Nur Izzati Binti Abd Haris on 23/07/2021.
//

import SwiftUI
import Foundation
import Combine

struct Add: View {
    @EnvironmentObject var recipesVM : RecipeViewModel
    
    @State var recipe = Recipe(
        id: "",
        title: "",
        image: "nasi",
        type: "",
        rating: 0,
        reviews: 0,
        description: "",
        author: "Izzati Haris",
        time: 1,
        serving: 1,
        ingredients: [],
        directions: [])
    
    @State private var newItem : String = ""
    @State private var newStep : String = ""
    @State private var textFieldText : String = ""
    @State private var selectedType : String = ""
    @State private var showAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("About Recipe")) {
                TextField("Insert recipe title", text: self.$recipe.title)
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    TextEditor(text: self.$recipe.description)
                        .padding(EdgeInsets(top: -7, leading: -4, bottom: -7, trailing: -4))
                    if self.recipe.description.isEmpty {
                        TextField("Description", text: $textFieldText)
                            .disabled(true)
                    }
                }
            }
            
            Section() {
                Picker(selection: $selectedType, label: Text("Recipe type")) {
                    ForEach(recipesVM.recipeType) { type in
                        Text(type.label)
                    }
                }.foregroundColor(.black)
                .id(selectedType)
            }
            
            Section(header: Text("Number of serving")) {
                HStack {
                    Image(systemName: "person").foregroundColor(.gray)
                    Stepper("\(self.recipe.serving) People", value: self.$recipe.serving, in: 1...20 )
                }
            }
            
            Section(header: Text("Time Preparation")) {
                HStack {
                    Image(systemName: "clock").foregroundColor(.gray)
                    Stepper("\(self.recipe.time) Minutes", value: self.$recipe.time, in: 1...1000 )
                }
            }
            
            Section(header: Text("Ingredients")) {
                HStack{
                    TextField("Add item...", text: self.$newItem)
                    Button(action: self.addItem, label: {
                        Text("Add")
                    })
                }
                List{
                    ForEach(recipe.ingredients, id: \.self) { item in
                        HStack(alignment: .top){
                            Image(systemName: "square.fill").foregroundColor(.orange)
                            Text(item)
                        }.padding(.bottom, 5)
                    }.onDelete(perform: self.deleteItem)
                }
            }
            
            Section(header: Text("Directions")) {
                HStack{
                    TextField("Add step...", text: self.$newStep)
                    Button(action: self.addStep, label: {
                        Text("Add")
                    })
                }
                List{
                    ForEach(recipe.directions, id: \.self) { item in
                        HStack(alignment: .top){
                            Image(systemName: "square.fill").foregroundColor(.orange)
                            Text(item)
                        }.padding(.bottom, 5)
                    }.onDelete(perform: self.deleteStep)
                }
            }
            
            Section {
                Button(action: self.postRecipe) {
                    HStack{
                        Spacer()
                        Text("Post Recipe")
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
            }
        }.navigationBarTitle("Add New Recipe")
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Recipe posted!"), message: Text("Thank your for posting new recipe"))
        })
    }
    
    func addItem() {
        recipe.ingredients.append(newItem)
        self.newItem = ""
    }
    
    func deleteItem(at offsets : IndexSet) {
        recipe.ingredients.remove(atOffsets: offsets)
    }
    
    func addStep() {
        recipe.directions.append(newStep)
        self.newStep = ""
    }
    
    func deleteStep(at offsets : IndexSet) {
        recipe.directions.remove(atOffsets: offsets)
    }
    
    func postRecipe() {
        let index = recipesVM.recipeType.firstIndex(where: {$0.id == selectedType}) ?? 0
        recipe.type = recipesVM.recipeType[index].label
        recipesVM.addNewRecipe(recipe: recipe)
        self.showAlert = true
        reset()
    }
    
    func reset() {
        recipe.id = ""
        recipe.title = ""
        recipe.image = "nasi"
        recipe.type = ""
        recipe.rating = 0
        recipe.reviews = 0
        recipe.description = ""
        recipe.author = "Izzati Haris"
        recipe.time = 1
        recipe.serving = 1
        recipe.ingredients = []
        recipe.directions = []
    }
}

struct Add_Previews: PreviewProvider {
    static var previews: some View {
        Add()
    }
}
