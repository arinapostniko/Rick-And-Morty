//
//  MainScreenViewController.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 17.08.23.
//

import UIKit
import SwiftUI

class MainScreenViewController: UIViewController {
    // MARK: - Public Properties
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.bold, size: 28)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Private Properties
    private var viewModel: MainScreenViewModel = MainScreenViewModel()
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
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCharacters(from: Links.rickAndMortyAPI.rawValue)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = UIColor(CustomColor.darkBlue)
        view.addSubview(headerLabel)
        viewModel = MainScreenViewModel()
        bindViewModel()
        view.addSubview(collectionView)
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "CharacterCell")
        setupConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.headerText.bind { [weak self] text in
            self?.headerLabel.text = text
        }
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
        DataManager.shared.fetch(APIData.self, from: url) { [weak self] result in
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
