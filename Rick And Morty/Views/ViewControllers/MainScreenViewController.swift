//
//  MainScreenViewController.swift
//  Rick And Morty
//
//  Created by Arina Postnikova on 17.08.23.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
    private var viewModel: MainScreenViewModel!
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Gilroy-Bold", size: 28)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(CustomColor.darkBlue)
        view.addSubview(headerLabel)
        setupConstraints()
        viewModel = MainScreenViewModel()
        bindViewModel()
    }
    
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.left.equalToSuperview().offset(24)
        }
    }
    
    private func bindViewModel() {
        viewModel.headerText.bind { [weak self] text in
            self?.headerLabel.text = text
        }
    }
}
