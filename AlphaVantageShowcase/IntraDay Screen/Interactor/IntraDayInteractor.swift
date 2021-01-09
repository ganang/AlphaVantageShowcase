//
//  IntraDayInteractor.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

class IntraDayInteractor: IntraDayInteractorProtocol {

    weak var presenter: IntraDayPresenterProtocol?
    
    func getIntraDay(withParams params: [String : String]) {
        StockProvider.shared.getIntraDayStock(endpoint: .stock, params: params) { (response) in
            self.presenter?.displayIntraDayResponse(withResponse: response)
        } onError: { (error) in
            self.presenter?.displayIntraDayError(withError: error)
        }

    }
    
}
