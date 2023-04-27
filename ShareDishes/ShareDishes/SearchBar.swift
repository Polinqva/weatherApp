//
//  SearchBar.swift
//  ShareDishes
//
//  Created by Polina Smirnova on 07.04.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    var onSearchButtonClicked: (() -> ())?
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.purple)
                .padding(.leading, 10)
            
            TextField("Search", text: $text)
                .padding(.vertical, 10)
                .padding(.leading, 10)
                .background(Color(.systemGray6))
                .cornerRadius(6)
                .overlay(
                    HStack {
                        if isSearching {
                            Button(action: {
                                text = ""
                                isSearching = false
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            })
                        }
                    }
                )
                .padding(.horizontal)
                .onTapGesture {
                    isSearching = true
                }
                .onChange(of: text, perform: { value in
                    if let onSearchButtonClicked = onSearchButtonClicked, value.isEmpty == false {
                        onSearchButtonClicked()
                    }
                })
            
            if isSearching {
                Button(action: {
                    text = ""
                    isSearching = false
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.purple)
                })
                .padding(.trailing)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .padding(.top, 20)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), isSearching: .constant(false))
    }
}
