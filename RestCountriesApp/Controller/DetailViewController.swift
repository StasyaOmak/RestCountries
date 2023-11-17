//
//  DetailViewController.swift
//  RestCountriesApp
//
//  Created by Anastasiya Omak on 16/11/2023.
//

import Foundation
import SDWebImage

class DetailViewController: UIViewController {
    
    let flagImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let nameLabel: UILabel = {
        let element = UILabel()
        element.text = "Country"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 30, weight: .bold)
        element.minimumScaleFactor = 0.5
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let officialNameLabel: UILabel = {
        let element = UILabel()
        element.text = "Official name:"
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 20, weight: .regular)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(flagImageView)
        view.addSubview(nameLabel)
        view.addSubview(officialNameLabel)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            officialNameLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 25),
            officialNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            officialNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: officialNameLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    public func configureUI(with countryModel: Country) {
        guard let url = URL(string: countryModel.flags.png) else { return }
        flagImageView.sd_setImage(with: url)
        nameLabel.text = countryModel.name.official
    }
}


