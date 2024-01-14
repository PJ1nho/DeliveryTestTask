//
//  DeliveryPresenter.swift
//  DeliveryApp
//
//  Created by Тихтей  Павел on 14.01.2024.
//

import UIKit

final class DeliveryPresenter: DeliveryPresenterProtocol {
    
    var view: DeliveryViewProtocol?
    
    private var bannerItems = [BannerViewModel]()
    private var menuItems = [DishViewModel]()
    private var categories = [String]()
    
    func setupView() {
        makeMenu()
        makeBannerItems()
    }
    
    func viewModel(at indexPath: IndexPath) -> GeneralViewModelProtocol? {
        switch indexPath.section {
        case 0:
            let bannerItem = bannerItems[indexPath.row]
            return bannerItem
        case 1:
            let menuItem = menuItems[indexPath.row]
            return menuItem
        default:
            return nil
        }
    }
    
    func headerViewModel() -> [String] {
        return categories
    }

    
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfItems(at section: Int) -> Int {
        switch section {
        case 0:
            return bannerItems.count
        case 1:
            return menuItems.count
        default:
            return 0
        }
    }
    
    func didSelectCategory(categoryTitle: String?) {
        let categoryIndex = menuItems.firstIndex{ $0.categoryTitle == categoryTitle } ?? 0
        view?.scrollToItem(index: categoryIndex)
    }
    
    private func makeMenu() {
        if let url = Bundle.main.url(forResource: "JsonApi", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(Menu.self, from: data)
                menuItems = response.menu.flatMap { categoryModel in
                    categoryModel.dishes.map {
                        DishViewModel(categoryTitle: categoryModel.title, image: UIImage(named: "pizza"), title: $0.name, description: $0.description, price: $0.price)
                    }
                }
                categories = response.menu.compactMap{ $0.title }
            } catch {
                print("Data not loaded")
            }
        }
    }
    
    private func makeBannerItems() {
        bannerItems = [
            UIImage(named: "bannerFirst"),
            UIImage(named: "bannerSecond"),
            UIImage(named: "bannerThird")
        ].map { BannerViewModel(image: $0) }
    }
}
