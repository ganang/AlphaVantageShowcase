//
//  IntraDayCell.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

class IntraDayCell: UITableViewCell {
    
    let dateLabelHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "Date/Time"
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let openLabelHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "Open"
        
        return label
    }()
    
    let openLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    let lowLabelHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "Low"
        
        return label
    }()
    
    let lowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    let highLabelHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "High"
        
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
        
        addSubview(dateLabelHeader)
        addSubview(openLabelHeader)
        addSubview(highLabelHeader)
        addSubview(lowLabelHeader)
    }
    
    func setupConstraint() {
        dateLabelHeader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateLabelHeader.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: dateLabelHeader.bottomAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateLabelHeader.leadingAnchor).isActive = true
        
        openLabelHeader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        openLabelHeader.leadingAnchor.constraint(equalTo: dateLabelHeader.trailingAnchor, constant: 72).isActive = true
        
        openLabel.topAnchor.constraint(equalTo: openLabelHeader.bottomAnchor, constant: 8).isActive = true
        openLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor,constant: 8).isActive = true
        
        highLabelHeader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        highLabelHeader.leadingAnchor.constraint(equalTo: openLabelHeader.trailingAnchor, constant: 36).isActive = true
        
        highLabel.topAnchor.constraint(equalTo: highLabelHeader.bottomAnchor, constant: 8).isActive = true
        highLabel.leadingAnchor.constraint(equalTo: openLabel.trailingAnchor,constant: 8).isActive = true
        
        lowLabelHeader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        lowLabelHeader.leadingAnchor.constraint(equalTo: highLabelHeader.trailingAnchor, constant: 36).isActive = true
        
        lowLabel.topAnchor.constraint(equalTo: lowLabelHeader.bottomAnchor, constant: 8).isActive = true
        lowLabel.leadingAnchor.constraint(equalTo: highLabel.trailingAnchor,constant: 8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

