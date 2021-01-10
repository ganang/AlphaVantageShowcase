//
//  BaseCell.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 10/01/21.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

