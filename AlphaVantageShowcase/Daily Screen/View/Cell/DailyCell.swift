//
//  DailyCell.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 09/01/21.
//

import UIKit

class DailyCell: UITableViewCell {
    
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
    
    let symbolsLabelHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.text = "Symbols"
        
        return label
    }()
    
    let symbol1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let symbol2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let symbol3Label: UILabel = {
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
    
    let open1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let open2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let open3Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
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
    
    let low1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let low2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    let low3Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        
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
        addSubview(dateLabelHeader)
        addSubview(dateLabel)
        
        addSubview(symbolsLabelHeader)
        addSubview(openLabelHeader)
        addSubview(open1Label)
        addSubview(open2Label)
        addSubview(open3Label)
        addSubview(lowLabelHeader)
        addSubview(low1Label)
        addSubview(low2Label)
        addSubview(low3Label)
        addSubview(symbol1Label)
        addSubview(symbol2Label)
        addSubview(symbol3Label)
    }
    
    func setupConstraint() {
        dateLabelHeader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateLabelHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateLabelHeader.trailingAnchor, constant: 16).isActive = true
        
        symbolsLabelHeader.topAnchor.constraint(equalTo: dateLabelHeader.bottomAnchor, constant: 8).isActive = true
        symbolsLabelHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        
        openLabelHeader.topAnchor.constraint(equalTo: dateLabelHeader.bottomAnchor, constant: 8).isActive = true
        openLabelHeader.leadingAnchor.constraint(equalTo: symbolsLabelHeader.trailingAnchor, constant: 32).isActive = true
        
        open1Label.topAnchor.constraint(equalTo: openLabelHeader.bottomAnchor, constant: 8).isActive = true
        open1Label.leadingAnchor.constraint(equalTo: openLabelHeader.leadingAnchor).isActive = true
        
        open2Label.topAnchor.constraint(equalTo: open1Label.bottomAnchor, constant: 8).isActive = true
        open2Label.leadingAnchor.constraint(equalTo: openLabelHeader.leadingAnchor).isActive = true
        
        open3Label.topAnchor.constraint(equalTo: open2Label.bottomAnchor, constant: 8).isActive = true
        open3Label.leadingAnchor.constraint(equalTo: openLabelHeader.leadingAnchor).isActive = true
        
        lowLabelHeader.topAnchor.constraint(equalTo: dateLabelHeader.bottomAnchor, constant: 8).isActive = true
        lowLabelHeader.leadingAnchor.constraint(equalTo: openLabelHeader.trailingAnchor, constant: 48).isActive = true
        
        low1Label.topAnchor.constraint(equalTo: lowLabelHeader.bottomAnchor, constant: 8).isActive = true
        low1Label.leadingAnchor.constraint(equalTo: lowLabelHeader.leadingAnchor).isActive = true
        
        low2Label.topAnchor.constraint(equalTo: low1Label.bottomAnchor, constant: 8).isActive = true
        low2Label.leadingAnchor.constraint(equalTo: lowLabelHeader.leadingAnchor).isActive = true
        
        low3Label.topAnchor.constraint(equalTo: low2Label.bottomAnchor, constant: 8).isActive = true
        low3Label.leadingAnchor.constraint(equalTo: lowLabelHeader.leadingAnchor).isActive = true
        
        symbol1Label.topAnchor.constraint(equalTo: symbolsLabelHeader.bottomAnchor, constant: 8).isActive = true
        symbol1Label.leadingAnchor.constraint(equalTo: symbolsLabelHeader.leadingAnchor).isActive = true
        
        symbol2Label.topAnchor.constraint(equalTo: symbol1Label.bottomAnchor, constant: 8).isActive = true
        symbol2Label.leadingAnchor.constraint(equalTo: symbolsLabelHeader.leadingAnchor).isActive = true
        
        symbol3Label.topAnchor.constraint(equalTo: symbol2Label.bottomAnchor, constant: 8).isActive = true
        symbol3Label.leadingAnchor.constraint(equalTo: symbolsLabelHeader.leadingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
