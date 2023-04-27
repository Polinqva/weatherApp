//
//  Recipe.swift
//  ShareDishes
//
//  Created by Polina Smirnova on 07.04.2023.
//

import Foundation

struct Recipe: Identifiable {
    let id: Int
    let title: String
    let imageURL: String?
    
    var imageURLString: String {
        return imageURL ?? ""
    }
    
    var imageURLURL: URL? {
        return URL(string: imageURLString)
    }
}
