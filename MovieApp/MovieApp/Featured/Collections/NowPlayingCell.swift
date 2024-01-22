//
//  NowPlayingCell.swift
//  MovieApp
//
//  Created by Marina Barros on 17/01/24.
//

import UIKit
import Kingfisher

final class NowPlayingCell: UICollectionViewCell {
    static let identifier = "NowPlayingCell"

    private lazy var posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textAlignment = .left
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    private lazy var ratingLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.text = "★"
        view.font = .systemFont(ofSize: 17)
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
            nameLabel,
            ratingLabel
        ])

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            posterImageView.heightAnchor.constraint(equalToConstant: 100),
            posterImageView.widthAnchor.constraint(equalToConstant: 61),
            nameLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2)
        ])
    }

    func setMovie(title: String, imagePath: String, rating: String) {
        nameLabel.text = title

        guard let url = URLImageHelper.shared.getURLFromImagePath(imagePath) else { return }
        self.posterImageView.kf.setImage(with: url)

        ratingLabel.text = "★" + rating
    }
}
