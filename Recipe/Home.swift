//
//  Login.swift
//  Recipe
//
//  Created by Nur Izzati Binti Abd Haris on 23/07/2021.
//

import Foundation
import SwiftUI


struct Home: View {
    @ObservedObject var recipesVM = RecipeViewModel()
    var body: some View {
        HStack {
            Image("avatar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50.0, height: 50)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            NavigationLink(destination: Search().environmentObject(recipesVM)) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame( width: 25, height: 25)
                    .foregroundColor(.black)
            }.buttonStyle(PlainButtonStyle())
            Spacer()
            NavigationLink(destination: Add().environmentObject(recipesVM)) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame( width: 50, height: 50)
                    .padding(.trailing, 10.0)
                    .foregroundColor(.orange)
            }.buttonStyle(PlainButtonStyle())
        }.padding(.horizontal, 10)
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
            VStack(alignment: .leading){
                Text("Hello Sarah!")
                    .font(.title2)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 10)
                Text("What would you want to cook today?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 15)
                Text("Top Rated Recipe")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(recipesVM.recipeList) { recipe in
                            if(recipe.rating >= 4.5) {
                                RecipeCardBig(recipe: recipe, recipesVM: recipesVM)
                            }
                        }
                    }
                }
                Spacer()
                HStack {
                    Text("Today Recommendation")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        .padding(.vertical, 10)
                    Spacer()
                    NavigationLink(destination: Search().environmentObject(recipesVM)) {
                        Text("See all")
                            .foregroundColor(.orange)
                            .padding(.trailing)
                    }
                }
                ForEach(recipesVM.recipeList[2...4]) { recipe in
                    RecipeCardSmall(recipe: recipe, recipesVM: recipesVM)
                        .padding(.trailing)
                        .padding(.vertical, 5)
                }
            }
            .padding(.leading)
            .foregroundColor(Color(UIColor.systemIndigo))
            .edgesIgnoringSafeArea(.bottom)
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct RecipeCardBig: View {
    var recipe: Recipe
    var recipesVM: RecipeViewModel
    
    var body: some View {
        NavigationLink(destination: Detail(recipe: recipe).environmentObject(recipesVM)) {
            Image(recipe.image)
                .resizable()
                .frame(width: 200, height: 300)
                .overlay(
                    HStack{
                        VStack(alignment: .leading) {
                            Spacer()
                            Text(recipe.title)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            HStack {
                                Image(systemName: "star.fill").foregroundColor(.orange)
                                Text("\(recipe.rating, specifier: "%.1f")")
                                    .foregroundColor(.orange)
                            }
                            Text("(\(recipe.reviews) Reviews)")
                                .foregroundColor(.white)
                        }.padding(.leading)
                        .padding(.bottom, 10)
                        Spacer()
                    }
                    .background(Color.black.opacity(0.5)), alignment: .bottomLeading)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }.buttonStyle(PlainButtonStyle())
    }
}


struct RecipeCardSmall: View{
    var recipe: Recipe
    var recipesVM: RecipeViewModel
    
    var body: some View {
        NavigationLink(destination: Detail(recipe: recipe).environmentObject(recipesVM)) {
            HStack(alignment: .top){
                Image(recipe.image)
                    .resizable()
                    .frame( width: 120, height: 120)
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Spacer()
                    Text(recipe.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Text(recipe.type)
                        .foregroundColor(.blue)
                    Spacer()
                    HStack {
                        Image(systemName: "star.fill").foregroundColor(.orange)
                        Text("\(recipe.rating, specifier: "%.1f") (\(recipe.reviews))").foregroundColor(.black)
                    }
                    Spacer()
                    HStack {
                        HStack {
                            Image(systemName: "clock").foregroundColor(Color.black.opacity(0.4))
                            Text("\(recipe.time) min").foregroundColor(Color.black.opacity(0.4))
                        }
                        Spacer()
                        HStack {
                            Image(systemName: "person").foregroundColor(Color.black.opacity(0.4))
                            Text("\(recipe.serving) serving").foregroundColor(Color.black.opacity(0.4))
                        }
                    }
                    Spacer()
                }
                Spacer()
                Image(systemName: "heart")
                    .padding(.top)
                    .foregroundColor(Color.black.opacity(0.7))
            }.padding(.trailing)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
