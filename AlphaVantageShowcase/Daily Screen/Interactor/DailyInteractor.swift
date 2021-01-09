//
//  DailyInteractor.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 09/01/21.
//

import UIKit

class DailyInteractor: DailyInteractorProtocol {

    weak var presenter: DailyPresenterProtocol?
    
    func getDaily(withParams params: [String : String]) {
        
        StockProvider.shared.getDailyStock(endpoint: .stock, params: params) { (DailyResponse) in
            self.presenter?.displayDailyResponse(withResponse: DailyResponse)
        } onError: { (error) in
            self.presenter?.displayDailyError(withError: error)
        }


    }
    
}
