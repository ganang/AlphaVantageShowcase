//
//  IntraDayWireframe.swift
//  AlphaVantageShowcase
//
//  Created by Ganang Arief Pratama on 08/01/21.
//

class IntraDayWireframe: IntraDayWireframeProtocol {
    class func createMainModule(intraDayRef: IntraDayViewController) {
        let presenter: IntraDayPresenterProtocol = IntraDayPresenter()
        
        intraDayRef.presenter = presenter
        intraDayRef.presenter?.wireframe = IntraDayWireframe()
        intraDayRef.presenter?.view = intraDayRef
        intraDayRef.presenter?.interactor = IntraDayInteractor()
        intraDayRef.presenter?.interactor?.presenter = presenter
    }
}

