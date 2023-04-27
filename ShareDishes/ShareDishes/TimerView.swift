//
//  TimerView.swift
//  ShareDishes

//
//  Created by Polina Smirnova on 08.04.2023.
//

import SwiftUI
import AVFoundation

struct TimerNumberView: View {
    @Binding var number: Int
    let range: ClosedRange<Int>
    let label: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(label)
                .font(.system(size: 22, weight: .bold, design: .monospaced))
            Stepper("", value: $number, in: range)
                .labelsHidden()
                .frame(width: 60)
        }
    }
}

struct TimerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var initialTimeInSeconds: Int = 0
    @State private var timeRemainingInSeconds: Int = 0
    @State private var timer: Timer?
    @State private var timerIsRunning: Bool = false
    @State private var soundPlayer: AVAudioPlayer?
    @State private var secondsRemaining: Int = 0
    
    private var timeRemaining: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Timer")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack(spacing: 20) {
                TimerNumberView(number: $hours, range: 0...23, label: "H")
                TimerNumberView(number: $minutes, range: 0...59, label: "M")
                TimerNumberView(number: $seconds, range: 0...59, label: "S")
            }
            
            
            if timeRemainingInSeconds > 0 {
                Text(timeFormatter.string(from: TimeInterval(timeRemainingInSeconds))!)
                    .font(.system(size: 70, design: .monospaced))
                    .foregroundColor(.pink)
                    .onAppear {
                        self.timeRemainingInSeconds = self.initialTimeInSeconds
                        self.startTimer()
                    }
            } else {
                Text("Time's up!")
                    .font(.system(size: 70, design: .monospaced))
                    .foregroundColor(.pink)
                Button(action: { [self] in
                    self.stopTimer()
                    playSound()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("OK")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.pink)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear { [self] in
            initialTimeInSeconds = self.hours * 3600 + self.minutes * 60 + self.seconds
            self.timeRemainingInSeconds = self.initialTimeInSeconds
        }
    }
    
    func startTimer() {
        guard timerIsRunning == false else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            if timeRemainingInSeconds > 0 {
                timeRemainingInSeconds -= 1
            } else {
                timerIsRunning = false
                timer.invalidate()
                self.timer = nil
                playSound()
            }
        }
        
        timerIsRunning = true
    }
func stopTimer() {
       timer?.invalidate()
       timerIsRunning = false
   }
   
   func playSound() {
       guard let soundURL = Bundle.main.url(forResource: "alarmSound", withExtension: "aiff") else { return }
       
       do {
           soundPlayer = try AVAudioPlayer(contentsOf: soundURL)
           soundPlayer?.play()
       } catch {
           print("Error playing sound: \(error.localizedDescription)")
       }
   }
}
