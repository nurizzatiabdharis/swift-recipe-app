//
//  ContentView.swift
//  Recipe
//
//  Created by Nur Izzati Binti Abd Haris on 23/07/2021.
//

import SwiftUI

struct Login: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15){
                Text("Daily Recipe")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundColor(.white)

                Text("Cooking is now easy")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.bottom)

                HStack {
                    Image(systemName: "envelope").foregroundColor(.gray)
                    TextField("Username", text: $username)
                }.frame(height: 60)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)

                HStack {
                    Image(systemName: "lock").foregroundColor(.gray)
                    SecureField("Password", text: $password)
                }.frame(height: 60)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)

                NavigationLink(destination: Home()) {
                    ButtonView()
                }
            }.background(
                Image("background")
                    .edgesIgnoringSafeArea(.all)
            ).offset(y: -50)
        }.accentColor(Color.orange)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ButtonView: View {
    var body: some View {
        Text("LOGIN")
            .frame(width: 220, height: 60, alignment: .center)
            .background(Color.orange)
            .cornerRadius(30)
            .foregroundColor(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Login().previewDevice("iPhone 8")
    }
}



