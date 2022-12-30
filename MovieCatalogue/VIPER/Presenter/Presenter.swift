//
//  Presenter.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import Foundation

//Object
//Protocol
//Ref to interactor, router, View

protocol MoviePresenter {
    var router:MovieRouter? {get set}
    var interactor:MovieInteractor? { get set}
    var view:MovieView? {get set}
 
    func movieInteractorDidFetchMovie(with result:Result<[MovieResults],AlertMessage>)
}

class MovieListPresenter:MoviePresenter{
    
    var view: MovieView?
    var router: MovieRouter?
    var interactor:MovieInteractor?{
        didSet{
            interactor?.getMoviesList()
        }
    }
    
  
    func movieInteractorDidFetchMovie(with result: Result<[MovieResults], AlertMessage>) {
        switch result{
            case .success(let results):
                    view?.update(with: results)
            case .failure(let _):
                view?.update(with: "Something went wrong.")
        }
    }
    
}
