//
//  SearchMovieViewController.swift
//  MovieApp
//
//  Created by Marina Barros on 19/01/24.
//

import UIKit

final class SearchMovieViewController: UIViewController {

    private let searchController: UISearchController
    
    private let viewModel: SearchMovieViewModel
    private let searchTableView: SearchMovieTableViewController
    
    init() {
        viewModel = SearchMovieViewModel()
        searchTableView = SearchMovieTableViewController(viewModel: viewModel)
        self.searchController = UISearchController(searchResultsController: searchTableView)
        super.init(nibName: nil, bundle: nil)
        searchTableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Busca"
        self.bind()
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    func bind() {
        viewModel.successSearchMovies = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.searchTableView.tableView.reloadData()
            }
        }
        
        viewModel.failedSearchMovies = { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(title: "Ops, ocorreu um erro.", message: errorMessage)
            }
        }
    }
}

extension SearchMovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.fetchSearchedMovies(query: text)
    }
}

extension SearchMovieViewController: SearchMovieTableViewDelegate {
    func goToMovieDetail(from index: Int) {
        guard let movie = viewModel.getMovieDetail(from: index) else { return }
        let viewModelDetail = MovieDetailViewModel(movie: movie)
        let controller = MovieDetailViewController(viewModel: viewModelDetail)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
