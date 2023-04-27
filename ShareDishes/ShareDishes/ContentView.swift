//
//  ContentView.swift
//  ShareDishes
//
//  Created by Polina Smirnova on 07.04.2023.
//
import SwiftUI

struct ContentView: View {
    @State private var selectedIndex = 0
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var isTimerViewShowing = true
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    @State private var timerIsRunning: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if selectedIndex == 0 {
                    Text("Home")
                } else if selectedIndex == 1 {
                    Button(action: {
                        isSearching.toggle()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(isSearching ? .purple : .primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                    
                    if isSearching {
                        TextField("Search", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                } else if selectedIndex == 2 {
                    Button(action: {
                        isTimerViewShowing.toggle()
                    }) {
                        Image(systemName: "clock")
                            .foregroundColor(.purple)
                    }
                    .sheet(isPresented: $isTimerViewShowing) {
                        TimerView()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                } else if selectedIndex == 3 {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.purple)
                }
                
                Spacer()
                
                MenuView(selectedIndex: $selectedIndex)
            }
            .navigationTitle("My App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
