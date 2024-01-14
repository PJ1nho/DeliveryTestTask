//
//  DeliveryPresenterProtocol.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 14.01.2024.
//

import UIKit

protocol DeliveryPresenterProtocol: AnyObject {
    
    // MARK: - Properties
    var view: DeliveryViewProtocol? { get set }
    
    // MARK: - Functions
    func setupView()
    
    func numberOfSections() -> Int
    
    func numberOfItems(at section: Int) -> Int
    
    func viewModel(at indexPath: IndexPath) -> GeneralViewModelProtocol?
    
    func headerViewModel() -> [String]
    
    func didSelectCategory(categoryTitle: String?) 
}
