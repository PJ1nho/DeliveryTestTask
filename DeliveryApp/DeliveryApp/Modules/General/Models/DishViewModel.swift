//
//  DishViewModel.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 14.01.2024.
//

import UIKit

struct DishViewModel: GeneralViewModelProtocol {
    let categoryTitle: String?
    let image: UIImage?
    let title: String?
    let description: String?
    let price: Int?
}
