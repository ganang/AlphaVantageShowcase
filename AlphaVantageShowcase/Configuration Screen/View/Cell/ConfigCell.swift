//
//  ConfigCell.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 10/01/21.
//

import UIKit

class ConfigCell: BaseCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    let parameterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change", for: .normal)
        button.titleLabel?.font =  .systemFont(ofSize: 10)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    override func setupViews() {
        setupInterfaceComponent()
        setupConstraints()
    }
    
    func setupInterfaceComponent() {
        addSubview(titleLabel)
        addSubview(parameterLabel)
        addSubview(changeButton)
    }
    
    func setupConstraints() {
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        parameterLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        parameterLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16).isActive = true
        
        changeButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        changeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        changeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        changeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        changeButton.layer.cornerRadius = 8
    }

}
