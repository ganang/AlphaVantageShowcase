//
//  IntraDayPresenter.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

import UIKit

class IntraDayPresenter: IntraDayPresenterProtocol {
    
    var interactor: IntraDayInteractorProtocol?
    weak var view: IntraDayViewControllerProtocol?
    var wireframe: IntraDayWireframeProtocol?
    
    func getIntraDay(withParams params: [String : String]) {
        self.interactor?.getIntraDay(withParams: params)
    }
    
    func displayIntraDayResponse(withResponse response: IntraDayResponse) {
        self.view?.displayIntraDayResponse(withResponse: response)
    }
    
    func displayIntraDayError(withError error: Error) {
        self.view?.displayIntraDayError(withError: error)
    }
}
