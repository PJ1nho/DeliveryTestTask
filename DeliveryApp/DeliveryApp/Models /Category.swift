//
//  Category.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 14.01.2024.
//

import Foundation

struct Category: Decodable {
    let title: String?
    let dishes: [Dish]
    
    private enum CodingKeys: String, CodingKey {
        case title
        case dishes = "Dishes"
    }
}
