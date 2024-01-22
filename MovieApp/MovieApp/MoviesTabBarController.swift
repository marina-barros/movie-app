//
//  MoviesTabBarController.swift
//  MovieApp
//
//  Created by Marina Barros on 17/01/24.
//

import UIKit

final class MoviesTabBarController: UITabBarController {
    private let tabImageNames = ["film", "magnifyingglass"]
    
    private lazy var featuredNavigation: UINavigationController = {
        let controller = FeaturedMoviesViewController()
        controller.title = "Destaques"
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }()
    
    private lazy var searchNavigation: UINavigationController = {
        let controller = SearchMovieViewController()
        controller.title = "Busca"
        let navigation = UINavigationController(rootViewController: controller)
        return navigation
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setViewControllers([featuredNavigation, searchNavigation], animated: false)
        setBarImages()
        self.tabBar.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBarImages() {
        guard let items = self.tabBar.items else { return }
        for index in 0..<items.count {
            items[index].image = UIImage(systemName: tabImageNames[index])
        }
    }
}
