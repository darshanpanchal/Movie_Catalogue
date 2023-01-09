//
//  Interactor.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import Foundation
//Object
//Protocol
//Ref to presenter

//--------
protocol MovieInteractor{
    var presenter:MoviePresenter? {get set}
    
    func getMoviesList(curentpage:Int)
}

class MovieListInteractor:MovieInteractor{
    var presenter: MoviePresenter?
    let movieAPIManager:MovieAPIManager = MovieAPIManager()
    
    func getMoviesList(curentpage:Int = 1) {
        let input = ["api_key":"32ea78d55ca5dd333c4e6ea14413dc5a","page":"\(curentpage)"]
        self.movieAPIManager.requestMovieListDetails(input: input) { result, error in
            if let movieResult = result?.results{
                self.presenter?.movieInteractorDidFetchMovie(with: .success(movieResult))
            }else if let  error = error {
                self.presenter?.movieInteractorDidFetchMovie(with: .failure(error))
            }
        }
    }
}

//-----------
protocol MovieDetailInteractor{
    var presenter:MovieDetailPresenter? {get set}
    func getMoviesDetails(movie:MovieResults)
    func getMoviesReviewDetails(movie:MovieResults)
    func getSimilarMovieDetails(movie:MovieResults,page:Int)
    func getCaseCrewMovieDetails(movie:MovieResults)
}
class MovieDetailsInteractor:MovieDetailInteractor{
    var presenter: MovieDetailPresenter?
    let movieAPIManager:MovieAPIManager = MovieAPIManager()
    
    func getMoviesDetails(movie: MovieResults) {
        let input = ["id":"\(movie.id ?? 0)","api_key":"32ea78d55ca5dd333c4e6ea14413dc5a"]
        self.movieAPIManager.requestMovieDetailsAPI(input: input) { result, error in
            if let movieResult = result{
                self.presenter?.movieDetailInteractorDidFetchMovieDetails(with: .success(movieResult))
            }else if let  error = error {
                self.presenter?.movieDetailInteractorDidFetchMovieDetails(with: .failure(error))
            }
        }
    }
    func getMoviesReviewDetails(movie: MovieResults) {
        let input = ["id":"\(movie.id ?? 0)","api_key":"32ea78d55ca5dd333c4e6ea14413dc5a"]
        self.movieAPIManager.requestMovieReviewAPI(input: input) { result, error in
            if let movieResult = result{
                self.presenter?.movieDetailInteractorDidFetchMovieReview(with: .success(movieResult))
            }else if let  error = error {
                self.presenter?.movieDetailInteractorDidFetchMovieReview(with: .failure(error))
            }
        }
    }
    func getSimilarMovieDetails(movie:MovieResults,page:Int = 1){
        let input = ["id":"\(movie.id ?? 0)","api_key":"32ea78d55ca5dd333c4e6ea14413dc5a","page":"\(page)"]
        self.movieAPIManager.requestSimilarMovieAPI(input: input) { result, error in
            if let movieResult = result{
                self.presenter?.movieDetailInteractorDidFetchSimilarMovie(with: .success(movieResult))
            }else if let  error = error {
                self.presenter?.movieDetailInteractorDidFetchMovieReview(with: .failure(error))
            }
        }
    }
    func getCaseCrewMovieDetails(movie:MovieResults){
        let input = ["id":"\(movie.id ?? 0)","api_key":"32ea78d55ca5dd333c4e6ea14413dc5a"]
        self.movieAPIManager.requestMovieCastCrewAPI(input: input) { result, error in
            if let movieResult = result{
                self.presenter?.movieDetailInteractorDidFetchMovieCast(with: .success(movieResult))
            }else if let  error = error {
                self.presenter?.movieDetailInteractorDidFetchMovieReview(with: .failure(error))
            }
        }
    }
    
    
}
