//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Student on 3/3/21.
//  Copyright © 2021 Student. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var scoreMessage = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "That is the flag of \(countries[correctAnswer])!"
            userScore = userScore + 1
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That is the flag of \(countries[number]), not \(countries[correctAnswer])!"
            userScore = userScore - 1
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)

                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                Spacer()

                ForEach(0 ..< 3) {number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Text("Current Score: \(userScore)")
                    .foregroundColor(Color.white)
                Spacer()
            }
            
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Score: \(userScore) \n \(scoreMessage)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
