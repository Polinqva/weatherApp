//
//  MenuView.swift
//  ShareDishes
//
//  Created by Polina Smirnova on 08.04.2023.
//

import Foundation
import SwiftUI

struct MenuView: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
        HStack {
            Button(action: {
                selectedIndex = 0
            }) {
                Image(systemName: "house")
                    .foregroundColor(selectedIndex == 0 ? .purple : .primary)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                selectedIndex = 1
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(selectedIndex == 1 ? .purple : .primary)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                selectedIndex = 2
            }) {
                Image(systemName: "clock")
                    .foregroundColor(selectedIndex == 2 ? .purple : .primary)
            }
            .frame(maxWidth: .infinity)
            
            Button(action: {
                selectedIndex = 3
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(selectedIndex == 3 ? .purple : .primary)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
