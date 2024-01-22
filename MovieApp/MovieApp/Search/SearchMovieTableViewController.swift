//
//  SearchMovieTableViewController.swift
//  MovieApp
//
//  Created by Marina Barros on 19/01/24.
//

import UIKit

protocol SearchMovieTableViewDelegate: AnyObject {
    func goToMovieDetail(from index: Int)
}

final class SearchMovieTableViewController: UITableViewController {
    private let viewModel: SearchMovieViewModel
    
    weak var delegate: SearchMovieTableViewDelegate?
    
    init(viewModel: SearchMovieViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
        self.tableView.register(SearchMovieCell.self, forCellReuseIdentifier: "SearchMovieCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieCell", for: indexPath)
        cell.textLabel?.text = viewModel.getMovieName(from: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.goToMovieDetail(from: indexPath.row)
    }
}
