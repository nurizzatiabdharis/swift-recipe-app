//
//  Detail.swift
//  Recipe
//
//  Created by Nur Izzati Binti Abd Haris on 23/07/2021.
//

import Foundation
import SwiftUI

struct Detail: View {
    @EnvironmentObject var recipesVM : RecipeViewModel
    var recipe: Recipe
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Image(recipe.image)
                .resizable()
                .scaledToFill()
                .frame(height: 200, alignment: .center)
                .clipped()
                .background(Color.black)
                .opacity(0.6)
            
            VStack(alignment: .leading){
                HStack {
                    Text(recipe.title)
                        .font(.system(size: 30, weight: .semibold))
                    Spacer()
                    NavigationLink(destination: Edit(recipe: recipe).environmentObject(recipesVM)) {
                        HStack {
                            Text("Edit").foregroundColor(.gray)
                            Image(systemName: "pencil").foregroundColor(.gray)
                        }
                        .padding(5)
                        .cornerRadius(5)
                        .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    }
                }
                Text(recipe.type).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                HStack(spacing: 10) {
                    HStack {
                        Image(systemName: "clock").foregroundColor(Color.black.opacity(0.4))
                        Text("\(recipe.time) min").foregroundColor(Color.black.opacity(0.4))
                    }
                    HStack {
                        Image(systemName: "person").foregroundColor(Color.black.opacity(0.4))
                        Text("\(recipe.serving) serving").foregroundColor(Color.black.opacity(0.4))
                    }
                    Spacer()
                }.padding(.bottom)
                Text(recipe.description)
                    .font(.body)
                    .lineLimit(nil)
                HStack{
                    Image("avatar2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45.0, height: 45)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .leading) {
                        Text("Recipe By \(recipe.author)").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("Professional Chef")
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame( width: 10, height: 15)
                        .padding(.trailing, 10.0)
                        .foregroundColor(.black)
                }
                .padding(5)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(5)
                .padding(.vertical, 10)
                
                Comment(rating: recipe.rating, reviews: recipe.reviews)
                Ingredients(ingredients: recipe.ingredients)
                Directions(directions: recipe.directions)
            }
            .padding(.all, 15)
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct Comment: View {
    var rating: Float
    var reviews: Int
    
    var body: some View {
        Divider()
        HStack {
            Text("Comment").font(.system(size: 18, weight: .semibold))
            Spacer()
            HStack {
                Text("Write a review").foregroundColor(.orange)
                Image(systemName: "chevron.right")
                    .foregroundColor(.orange)
            }
        }
        HStack {
            Image("avatar4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45.0, height: 45)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
            Image("avatar3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45.0, height: 45)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                .padding(.leading, -30)
            
            VStack{
                StarsView(rating: CGFloat(rating), maxRating: 5)
                HStack{
                    Text("\(rating, specifier: "%.1f")")
                        .foregroundColor(.orange)
                    Text("(\(reviews) Reviews)")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
    }
}

struct StarsView: View {
    let rating: CGFloat
    let maxRating: CGFloat
    private let size: CGFloat = 20
    
    var body: some View {
        let star = HStack(spacing: 0) {
            ForEach(0..<5) { _ in
                Image(systemName: "star.fill")
                .resizable()
                .frame(width: size, height: size, alignment: .center)
            }
        }

        ZStack {
            star
            HStack(content: {
                GeometryReader(content: { geometry in
                    HStack(spacing: 0, content: {
                        let width1 = self.valueForWidth(geometry.size.width+10, value: rating)
                        let width2 = self.valueForWidth(geometry.size.width+10, value: (maxRating - rating))
                        Rectangle()
                            .frame(width: width1, height: geometry.size.height, alignment: .center)
                            .foregroundColor(.orange)
                        Rectangle()
                            .frame(width: width2, height: geometry.size.height, alignment: .center)
                            .foregroundColor(.gray)
                    })
                })
                .frame(width: size * maxRating, height: size, alignment: .trailing)
            })
            .mask(
                star
            )
        }
        .frame(width: size * maxRating, height: size, alignment: .leading)
    }
    
    func valueForWidth(_ width: CGFloat, value: CGFloat) -> CGFloat {
        value * width / maxRating
    }
}

struct Ingredients: View {
    
    var ingredients: [String]
    
    var body: some View {
        Divider()
        Text("Ingredients")
            .font(.system(size: 18, weight: .semibold))
            .padding(.bottom, 5)
        ForEach(ingredients, id: \.self) { item in
            HStack{
                Image(systemName: "square.fill").foregroundColor(.orange)
                Text(item)
            }.padding(.bottom, 5)
        }
    }
}

struct Directions: View {

    var directions: [String]

    var body: some View {
        Divider()
        Text("Directions")
            .font(.system(size: 18, weight: .semibold))
            .padding(.bottom, 5)
        ForEach(directions.indices, id: \.self) { index in
            HStack(alignment: .top){
                Text("\(index+1) .").foregroundColor(.orange)
                Text(directions[index])
            }.padding(.bottom, 5)
        }

    }
}
