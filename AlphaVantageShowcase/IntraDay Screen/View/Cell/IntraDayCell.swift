//
//  IntraDayCell.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

class IntraDayCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let openLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    let lowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    let highLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        setupInterfaceComponent()
        setupConstraint()
    }
    
    func setupInterfaceComponent() {
        addSubview(dateLabel)
        addSubview(openLabel)
        addSubview(highLabel)
        addSubview(lowLabel)
    }
    
    func setupConstraint() {
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8).isActive = true
        
        openLabel.centerYAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        openLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8).isActive = true
        
        highLabel.centerYAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        highLabel.leadingAnchor.constraint(equalTo: openLabel.trailingAnchor,constant: 8).isActive = true
        
        lowLabel.centerYAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        lowLabel.leadingAnchor.constraint(equalTo: highLabel.trailingAnchor,constant: 8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

