//
//  Menu.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 13.01.2024.
//

import Foundation

struct Menu: Decodable {
    let menu: [Category]
    
    private enum CodingKeys: String, CodingKey {
        case data
        case menu = "Menu"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.menu = try dataContainer.decode([Category].self, forKey: .menu)
    }
}
