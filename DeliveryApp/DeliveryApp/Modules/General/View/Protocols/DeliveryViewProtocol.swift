//
//  DeliveryViewProtocol.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 14.01.2024.
//

import Foundation

protocol DeliveryViewProtocol: AnyObject {
    var presenter: DeliveryPresenterProtocol { get }
    
    func scrollToItem(index: Int)
}

