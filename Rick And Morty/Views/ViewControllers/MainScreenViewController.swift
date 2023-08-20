//
//  MainScreenViewController.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 17.08.23.
//

import UIKit
import SwiftUI

class MainScreenViewController: UIViewController {
    // MARK: - Private Properties
    private var apiData: APIData?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 20 * 3) / 2, height: 202)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCharacters(from: Links.rickAndMortyAPI.rawValue)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = UIColor(CustomColor.darkBlue)
        
        view.addSubview(collectionView)
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "CharacterCell")
        setupConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionView
extension MainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        apiData?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CharacterCell",
            for: indexPath) as? CharacterCell
        else {
            return UICollectionViewCell()
        }
        let character = apiData?.results[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}

extension MainScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCharacter = apiData?.results[indexPath.row] {
            let detailsView = DetailsScreenView(character: selectedCharacter)
            let hostingController = UIHostingController(rootView: detailsView)
            if let navigationController = navigationController {
                navigationController.pushViewController(hostingController, animated: true)
            }
        }
    }
}

// MARK: - DataManager
extension MainScreenViewController {
    private func fetchCharacters(from url: String) {
        activityIndicator.startAnimating()
        DataManager.shared.fetch(APIData.self, from: url) { [weak self] result in
            self?.activityIndicator.stopAnimating()
            switch result {
            case .success(let apiData):
                self?.apiData = apiData
                print("Data loaded: \(apiData.results.count) characters")
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
