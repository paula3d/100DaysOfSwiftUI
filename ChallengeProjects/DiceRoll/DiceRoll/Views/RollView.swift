//
//  RollView.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import SwiftUI

struct RollView: View {
    
    @EnvironmentObject var dices : Dices
    @EnvironmentObject var rolls : Rolls
    @EnvironmentObject var usersDices : UsersDices
    
    @State var rolledValues = [Int]()
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @State var valuesForAnimation = [Int](repeating: Int.random(in: 1...4), count: 10)
    let timer = Timer.publish(every: 0.25, on: .main, in: .common)
    @State var timeRemaining = 20
    
    enum RollProgress {
        case ready, inProgress, finished
    }
    @State var progress : RollProgress = .ready
    
    var body: some View {
        NavigationView {
            if usersDices.dices.isEmpty {
                Text("No dice selected")
            } else {
                VStack {
                    List {
                        ForEach(Array(usersDices.dices.enumerated()), id: \.element) { index, dice in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(dice.sides)-sided dice")
                                        .font(.headline)
                                    Text("Total rolled: \(dices.getTotalValue(dice))")
                                        .font(.subheadline)
                                }
                                Spacer()
                                ZStack {
                                    Text("\(valuesForAnimation[index])")
                                        .opacity(progress == .inProgress ? 0.7 : 0)
                                    
                                    Text("\(usersDices.rolling ? String(rolledValues[index]) : "Roll!")")
                                        .opacity(progress == .inProgress ? 0 : 1)
                                }
                            }
                        }
                    }
                    Button {
                        rollDice()
                    } label: {
                        Text("Roll the dice")
                            .font(.title)
                    }
                    .disabled(progress == .inProgress)
                    .padding()
                }
                .onChange(of: progress) { progress in
                    if progress == .inProgress {
                        startTimer()
                    }
                    if progress == .finished {
                        feedback.notificationOccurred(.success)
                    }
                }
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        rollingAnimation()
                        timeRemaining -= 1
                    } else {
                        timeRemaining = 0
                        progress = .finished
                    }
                }
                .navigationTitle("Roll the dice!")
            }
        }
    }
    
    func rollDice() {
        
        progress = .inProgress
        resetRoll()
        feedback.prepare()
        
        let newRoll = Roll()
        newRoll.addDices(usersDices.dices)
        
        for dice in usersDices.dices {
            let rolledValue = Int.random(in: 1...dice.sides)
            rolledValues.append(rolledValue)
            addValueToTotal(dice: dice, value: rolledValue)
        }
        
        newRoll.addValues(rolledValues)
        rolls.add(newRoll)
        
        usersDices.setRolling(to: true)
    }
    
    func resetRoll() {
        rolledValues = [Int]()
        usersDices.setRolling(to: false)
    }
    
    func addValueToTotal(dice : Dice, value : Int) {
        dices.addToTotal(dice: dice, num: value)
    }
    
    func startTimer() {
        timeRemaining = 20
        timer.connect()
    }
    
    func rollingAnimation() {
        
        let dicesInUse = usersDices.dices.count
        for i in 0..<dicesInUse {
            valuesForAnimation[i] = Int.random(in: 1...usersDices.dices[i].sides)
        }
        timeRemaining -= 1
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
