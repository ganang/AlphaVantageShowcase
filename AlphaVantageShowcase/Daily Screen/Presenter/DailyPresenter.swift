//
//  DailyPresenter.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 09/01/21.
//

import UIKit

class DailyPresenter: DailyPresenterProtocol {
    
    var interactor: DailyInteractorProtocol?
    weak var view: DailyViewControllerProtocol?
    var wireframe: DailyWireframeProtocol?
    
    func getDaily(withParams params: [String : String]) {
        self.interactor?.getDaily(withParams: params)
    }
    
    func displayDailyResponse(withResponse response: DailyResponse) {
        self.view?.displayDailyResponse(withResponse: response)
    }
    
    func displayDailyError(withError error: Error) {
        self.view?.displayDailyError(withError: error)
    }
    
}


