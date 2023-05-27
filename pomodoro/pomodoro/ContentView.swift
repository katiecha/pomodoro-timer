//
//  ContentView.swift
//  pomodoro
//
//  Created by Katie Chai on 2/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var timeLeft = 1500
    @State private var isRunning = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.red)
                    
                    Circle()
                        .frame(width: 190, height: 190)
                        .foregroundColor(.white)
                    
                    Text(timeString(time: timeLeft))
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
                .padding(.top, 100)
                
                HStack {
                    Button(action: {
                        self.startTimer()
                    }) {
                        Text("Start")
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .disabled(isRunning)
                    
                    Button(action: {
                        self.stopTimer()
                    }) {
                        Text("Stop")
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .disabled(!isRunning)
                    
                    Button(action: {
                        self.resetTimer()
                    }) {
                        Text("Reset")
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                }
                .padding(.top, 50)
            }
        }
        .onReceive(timer) { time in
            if self.isRunning {
                if self.timeLeft > 0 {
                    self.timeLeft -= 1
                } else {
                    self.isRunning = false
                }
            }
        }
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func startTimer() {
        if !isRunning {
            isRunning = true
        }
    }
    
    func stopTimer() {
        if isRunning {
            isRunning = false
        }
    }
    
    func resetTimer() {
        timeLeft = 1500
        isRunning = false
    }
    
    func timeString(time:Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format:"%02d:%02d", minutes, seconds)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
