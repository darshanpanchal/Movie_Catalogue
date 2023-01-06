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
            interactor?.getMoviesList(curentpage: 1)
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
//========
protocol MovieDetailPresenter {
    var router:MovieRouter? {get set}
    var interactor:MovieDetailInteractor? { get set}
    var view:MovieDetailView? {get set}
 
    func movieDetailInteractorDidFetchMovieDetails(with result:Result<MovieDetailDataBase,AlertMessage>)
    func movieDetailInteractorDidFetchMovieReview(with result:Result<MovieReviewBase,AlertMessage>)
}

class MovieDetailsPresenter:MovieDetailPresenter{
    
    var view: MovieDetailView?
    var router: MovieRouter?
    var interactor:MovieDetailInteractor?
       
  
    func movieDetailInteractorDidFetchMovieDetails(with result: Result<MovieDetailDataBase, AlertMessage>) {
        switch result{
            case .success(let results):
                    view?.updatewithMovieDetails(movie: results)
            case .failure(let _):
                    view?.update(with: "Something went wrong.")

        }
    }
    func movieDetailInteractorDidFetchMovieReview(with result: Result<MovieReviewBase, AlertMessage>) {
        switch result{
            case .success(let results):
                    view?.updatewithMovieReview(movie: results)
            case .failure(let _):
                    view?.update(with: "Something went wrong.")

        }
    }
    
}
