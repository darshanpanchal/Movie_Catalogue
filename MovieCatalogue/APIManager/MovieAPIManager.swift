//
//  MovieAPIManager.swift
//  MovieCatalogue
//
//  Created by Darshan on 30/12/22.
//

import Foundation
import Alamofire

enum MovieAPI {
    case GETMovieAPI
}
extension MovieAPI: EndPointType {
   
    var httpMethod: HTTPMethod {
        switch self {
        case .GETMovieAPI:
            return .get
        default:
            return .post
        }
    }
    
    var version: String {
        return "1"
    }
    
    var path: String {
        switch self {
        case .GETMovieAPI:
            return "now_playing"
        }}
}
class MovieAPIManager{
    
    func requestMovieListDetails(input: Parameters?, handler: @escaping (_ result: MovieListDataBase?, _ error: AlertMessage?)->()) {
        APIManager.shared().call(type: MovieAPI.GETMovieAPI, params: input) { (result: MovieListDataBase?, message: AlertMessage?) in
            if let result = result {
                handler(result, nil)
            } else {
                handler(nil, message!)
            }
        }
    }
}
