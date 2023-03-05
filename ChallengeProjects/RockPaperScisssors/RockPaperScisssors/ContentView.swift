//
//  ContentView.swift
//  RockPaperScisssors
//
//  Created by Paulina Dąbrowska on 09/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves : [String] = ["🗿", "📄", "✂️"]
    @State private var gameChoice : Int = Int.random(in: 0...2)
    @State private var playerChoice : Int = 0
    @State private var hasToWin : Bool = Bool.random()
    
    @State private var score : Int = 0
    @State private var round : Int = 0
    
    @State private var showingScore : Bool = false
    
    @State private var changingBackground : Bool = false
    
    var body: some View {
        
        ZStack {
            
            VStack {
                HStack {
                    Spacer()
                    Button() {
                        changingBackground.toggle()
                    } label: {
                        Text("Change background")
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                VStack {
                    Text(moves[gameChoice])
                        .font(.system(size: 200))
                        .fontWeight(.bold)
                }
                Spacer()
                Text("Choose an appropriate move to ")
                Text(hasToWin == true ? "Win" : "Lose")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                HStack (spacing: 40) {
                    ForEach(0..<3) { number in
                        Button {
                            checkScore(playerChoice: number)
                        } label: {
                            Text(moves[number])
                                .font(.system(size: 100))
                        }
                        
                    }
                }
                Spacer()
                Text("Score: \(score)")
                    .font(.headline)
            }
            .padding()
        }
        .background(changingBackground ? .teal : .orange)
        .alert("Game finished",isPresented: $showingScore) {
            Button("Play again", action: resetGame)
        } message: {
            Text("\(round) rounds completed. Your score is \(score)")
        }
    }
    
    func checkScore(playerChoice: Int) {
        
        var correctAnswer : Int
        
        if hasToWin {
            switch gameChoice {
            case 0:
                correctAnswer = 1
                break;
            case 1:
                correctAnswer = 2
                break;
            default:
                correctAnswer = 0
                break;
            }
        } else {
            switch gameChoice {
            case 0:
                correctAnswer = 2
                break;
            case 1:
                correctAnswer = 0
                break;
            default:
                correctAnswer = 1
                break;
            }
        }
        
        if playerChoice == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
        
        newRound()
        
        if round == 10 {
            showingScore = true
        }
    }
    
    func newRound(){
        gameChoice = Int.random(in: 0...2)
        hasToWin = Bool.random()
        round += 1
    }
    
    func resetGame() {
        score = 0
        round = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
