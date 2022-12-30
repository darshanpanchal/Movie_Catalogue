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


protocol MovieInteractor{
    var presenter:MoviePresenter? {get set}
    
    func getMoviesList()
}

class MovieListInteractor:MovieInteractor{
    var presenter: MoviePresenter?
    let movieAPIManager:MovieAPIManager = MovieAPIManager()
    
    func getMoviesList() {
        let input = ["api_key":"32ea78d55ca5dd333c4e6ea14413dc5a"]
        self.movieAPIManager.requestMovieListDetails(input: input) { result, error in
            if let movieResult = result?.results{
                self.presenter?.movieInteractorDidFetchMovie(with: .success(movieResult))
            }else if let  error = error {
                self.presenter?.movieInteractorDidFetchMovie(with: .failure(error))
            }
        }
    }
}

