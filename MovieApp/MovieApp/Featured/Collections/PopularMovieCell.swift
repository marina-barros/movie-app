//
//  PopularMovieCell.swift
//  MovieApp
//
//  Created by Marina Barros on 17/01/24.
//

import UIKit

final class PopularMovieCell: UICollectionViewCell {
    static let identifier = "PopularMovieCell"

    private lazy var posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        addSubviews([
            posterImageView,
            nameLabel
        ])

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            posterImageView.widthAnchor.constraint(equalToConstant: 300),
            posterImageView.heightAnchor.constraint(equalToConstant: 100),
            nameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setMovie(title: String, imagePath: String) {
        nameLabel.text = title
        
        guard let url = URLImageHelper.shared.getURLFromImagePath(imagePath) else { return }
        self.posterImageView.kf.setImage(with: url)
    }
}
