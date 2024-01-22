//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Marina Barros on 18/01/24.
//

import UIKit
import Kingfisher

final class MovieDetailView: UIScrollView {
    private lazy var biggerPoster: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var smallerPoster: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var movieCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Sinopse"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overViewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        configureViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(biggerPosterPath path: String) {
        guard let url = URLImageHelper.shared.getURLFromImagePath(path) else { return }
        self.biggerPoster.kf.setImage(with: url)
    }
    
    func set(smallerPosterPath path: String) {
        guard let url = URLImageHelper.shared.getURLFromImagePath(path) else { return }
        self.smallerPoster.kf.setImage(with: url)
    }
    
    func set(rating: String) {
        ratingLabel.text = rating
    }
    
    func set(overview: String) {
        overViewLabel.text = overview
    }
}

extension MovieDetailView: BaseViewCode {
    func setupSubviews() {
        addSubview(contentStackView)
        movieCard.addSubviews([smallerPoster, ratingLabel])
        overviewCard.addSubviews([overviewTitleLabel, overViewLabel])
        contentStackView.addArrangedSubviews([
            biggerPoster,
            titleLabel,
            movieCard,
            overviewCard
        ])
    }
    
    func setupConstraints() {
        contentStackView.fill(view: self)
        
        NSLayoutConstraint.activate([
            contentStackView.widthAnchor.constraint(equalTo: widthAnchor),
            
            biggerPoster.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            biggerPoster.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            biggerPoster.widthAnchor.constraint(equalToConstant: 382),
            biggerPoster.heightAnchor.constraint(equalToConstant: 204),
            
            
            titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
            
            smallerPoster.topAnchor.constraint(equalTo: movieCard.topAnchor, constant: 8),
            smallerPoster.leadingAnchor.constraint(equalTo: movieCard.leadingAnchor, constant: 16),
            smallerPoster.widthAnchor.constraint(equalToConstant: 124),
            smallerPoster.heightAnchor.constraint(equalToConstant: 192),
            smallerPoster.bottomAnchor.constraint(equalTo: movieCard.bottomAnchor, constant: -11),
            
            ratingLabel.topAnchor.constraint(equalTo: smallerPoster.topAnchor, constant: 4),
            ratingLabel.leadingAnchor.constraint(equalTo: smallerPoster.trailingAnchor, constant: 8),
            
            overviewTitleLabel.leadingAnchor.constraint(equalTo: overviewCard.leadingAnchor, constant: 16),
            overviewTitleLabel.topAnchor.constraint(equalTo: overviewCard.topAnchor, constant: 11),
            
            overViewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 4),
            overViewLabel.leadingAnchor.constraint(equalTo: overviewCard.leadingAnchor, constant: 16),
            overViewLabel.trailingAnchor.constraint(equalTo: overviewCard.trailingAnchor, constant: -16),
            overViewLabel.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -24)
        ])
    }
    
    func setupUI() {
        contentStackView.setCustomSpacing(16, after: biggerPoster)
        contentStackView.setCustomSpacing(0, after: titleLabel)
    }
}
