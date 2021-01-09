//
//  DailyWireframe.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 09/01/21.
//

import Foundation

class DailyWireframe: DailyWireframeProtocol {
    class func createMainModule(dailyRef: DailyViewController) {
        let presenter: DailyPresenterProtocol = DailyPresenter()
        
        dailyRef.presenter = presenter
        dailyRef.presenter?.wireframe = DailyWireframe()
        dailyRef.presenter?.view = dailyRef
        dailyRef.presenter?.interactor = DailyInteractor()
        dailyRef.presenter?.interactor?.presenter = presenter
    }
}
