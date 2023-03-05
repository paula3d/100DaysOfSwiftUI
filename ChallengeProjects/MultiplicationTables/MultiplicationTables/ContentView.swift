//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Paulina Dąbrowska on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingSettings = true
    
    // data & player's choices
    @State private var possibleNumberOfQuestions = [5, 10, 20]
    @State private var numberOfQuestions = 5
    @State private var multiplicationTable = 2
    
    // animation variables
    @State private var tappedButton = 0
    @State private var scale = 1.0
    
    // game variables
    @State private var round = 0
    @State private var gameCompleted = false
    @State private var question = "Test question"
    @State private var score = 0
    @State private var numberOne = 0
    @State private var numberTwo = 0
    @State private var correctResult = 0
    @State private var possibleAnswers = [1, 2, 3, 4]
    @State private var chosenAnswer = 5
    
    // alert vaiables
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertPrimaryButton = ""
    @State private var alertSecondaryButton = ""
    @State private var alertShowing = false
    
    @State private var backButtonPressed = false
    
    var body: some View {
        
        if showingSettings {
            
            ZStack {
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: .blue, location: 0.5),
                    Gradient.Stop(color: .teal, location: 0.95),
                ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 30.0) {
                    
                    Text("Game setup")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .padding(10)
                    
                    VStack(spacing: 25) {
                        Text("What size of a table do you want to learn?")
                        
                        HStack {
                            Text("\(multiplicationTable)")
                                .fontWeight(.semibold)
                            Spacer()
                            Button {
                                multiplicationTable -= 1
                            } label: {
                                Text(.init(systemName: "minus"))
                            }
                            .padding(7)
                            .background(.white.opacity(0.2))
                            .containerShape(Circle())
                            .opacity(multiplicationTable == 2 ? 0.3 : 1)
                            .disabled(multiplicationTable == 2)
                            
                            Button {
                                multiplicationTable += 1
                            } label: {
                                Text(.init(systemName: "plus"))
                            }
                            .padding(7)
                            .background(.white.opacity(0.2))
                            .containerShape(Circle())
                            .opacity(multiplicationTable == 12 ? 0.3 : 1)
                            .disabled(multiplicationTable == 12)
                        }
                        .padding(.horizontal, 50)
                    }
                    
                    Rectangle()
                        .fill(.white)
                        .frame(width: 250, height: 1)
                    
                    VStack(spacing: 20) {
                        Text("How many questions do you want to be asked?")
                        HStack(spacing: 20) {
                            ForEach(0..<3) { number in
                                Button {
                                    numberOfQuestions = possibleNumberOfQuestions[number]
                                    tappedButton = number
                                    withAnimation {
                                        scale = 1.2
                                    }
                                } label: {
                                    Text("\(possibleNumberOfQuestions[number])")
                                }
                                .frame(width: 70, height: 70)
                                .background(.white.opacity(0.3))
                                .containerShape(Circle())
                                .opacity(tappedButton == number ? 0.9 : 0.3)
                                .scaleEffect(tappedButton == number ? scale : 1)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            withAnimation {
                                changeScene()
                            }
                        }
                    } label: {
                        Text("Start the game")
                    }
                    .font(.system(size: 30))
                    .padding(30)
                    .background(.white.opacity(0.3))
                    .cornerRadius(30)
                    
                    Spacer()
                }
                .padding(.horizontal, 50.0)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
            }
            .foregroundColor(.white)
        } else {
            ZStack {
                LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: .blue, location: 0.5),
                    Gradient.Stop(color: .teal, location: 0.95),
                ]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button {
                            showReturnAlert()
                        } label: {
                            Text(.init(systemName: "chevron.backward"))
                        }
                        Spacer()
                    }
                    
                    Text("Question \(round) of \(numberOfQuestions)")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .padding(10)
                    
                    Text(question)
                        .font(.title)
                    
                    HStack{
                        Text("\(numberOne)")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .padding(10)
                        Text("x")
                        Text("\(numberTwo)")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                            .padding(10)
                    }
                    
                    Spacer()
                    
                    HStack {
                        ForEach(0..<4){ number in
                            Button {
                                chosenAnswer = number
                                withAnimation {
                                    scale = 1.2
                                }
                                checkAnswer()
                            } label: {
                                Text("\(possibleAnswers[number])")
                            }
                            .frame(width: 70, height: 70)
                            .background(.white.opacity(0.3))
                            .containerShape(Circle())
                            .opacity(chosenAnswer == number ? 0.9 : 0.7)
                            .scaleEffect(chosenAnswer == number ? scale : 1)
                        }
                    }
                    Spacer()
                    Spacer()
                }
                .padding(.horizontal, 50.0)
                .foregroundColor(.white)
            }
            .onAppear(perform: setupGame)
            .alert(alertTitle, isPresented: $alertShowing){
            
                if backButtonPressed || gameCompleted {
                    Button(alertPrimaryButton, role: .none){
                        gameCompleted = false
                        backButtonPressed = false
                        changeScene()
                    }
                }
                Button(alertSecondaryButton, role: .cancel){
                    
                    if gameCompleted {
                        gameCompleted = false
                        setupGame()
                        return
                    }
                    
                    if !backButtonPressed {
                        if round == numberOfQuestions {
                            gameCompleted = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                showScoreAlert()
                            }
                        }
                        if !gameCompleted {
                            generateQuestion()
                        }
                    }
                    
                    backButtonPressed = false
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func changeScene() {
        showingSettings.toggle()
    }
    
    func generateQuestion() {
    
        chosenAnswer = 5
        round += 1
        question = "What is the result of...?"
        
        numberOne = Int.random(in: 1...multiplicationTable)
        numberTwo = Int.random(in: 1...multiplicationTable)
        
        correctResult = numberOne * numberTwo
        
        possibleAnswers = [correctResult, correctResult - 1, numberOne * (numberTwo + 1), numberTwo * 10 + numberOne]
        possibleAnswers.shuffle()
    }
    
    func checkAnswer() {
        if possibleAnswers[chosenAnswer] == correctResult {
            alertTitle = "Correct!"
            score += 1
        } else {
            alertTitle = "Wrong!"
        }
        
        alertSecondaryButton = "OK"
        alertMessage = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            alertShowing = true
        }
    }
    
    func setupGame() {
        round = 0
        score = 0
        
        generateQuestion()
    }
    
    func showReturnAlert(){
        alertTitle = ""
        alertMessage = "Are you sure that you want to return to previous screen? It will dismiss your current progress"
        alertPrimaryButton = "Yes"
        alertSecondaryButton = "Cancel"
        
        backButtonPressed = true
        
        alertShowing = true
    }
    
    func showScoreAlert(){
        alertTitle = "Game completed"
        alertMessage = "Your score is \(score)"
        alertPrimaryButton = "Change settings"
        alertSecondaryButton = "Play again"
        
        alertShowing = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
