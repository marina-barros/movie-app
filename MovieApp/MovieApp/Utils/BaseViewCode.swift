//
//  BaseViewCode.swift
//  MovieApp
//
//  Created by Marina Barros on 16/01/24.
//

protocol BaseViewCode {
    func configureViewCode()
    func setupSubviews()
    func setupConstraints()
    func setupUI()
}

extension BaseViewCode {
    func configureViewCode() {
        setupSubviews()
        setupConstraints()
        setupUI()
    }

    func setupUI() {}
}
