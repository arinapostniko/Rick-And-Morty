//
//  CharacterCell.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 18.08.23.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    // MARK: - Public Properties
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.semiBold, size: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Private Properties
    private var imageURL: URL? {
        didSet {
            characterImageView.image = nil
            updateImage()
        }
    }
    
    // MARK: - Override Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with character: Character?) {
        nameLabel.text = character?.name
        print("Configuring cell with name: \(character?.name ?? "No name")")
        imageURL = URL(string: character?.image ?? "")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = UIColor(CustomColor.darkGrey)
        addSubview(characterImageView)
        addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            characterImageView.heightAnchor.constraint(equalToConstant: 140),
            characterImageView.widthAnchor.constraint(equalToConstant: 140),
            
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cachedImage = CacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        DataManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                CacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
                completion(.success(uiImage))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        print("Updating image for URL: \(imageURL)")
        getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    if imageURL == self?.imageURL {
                        print("Setting image for URL: \(imageURL)")
                        self?.characterImageView.image = image
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
