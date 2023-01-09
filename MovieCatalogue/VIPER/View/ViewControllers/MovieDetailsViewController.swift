//
//  MovieDetailsViewController.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var buttonBack:UIButton!
    @IBOutlet weak var tableView:UITableView!
    
    
    var currentMovieDetails:MovieDetailDataBase?
    var currentCastCrewDetails:MovieCaseCrewBase?
    var currentReviewDetail:MovieReviewBase?
    var currentSimilarResults:SimilarMovieBase?
    
    //VIPER
    var presenter:MovieDetailPresenter?
    var movie:MovieResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        // Do any additional setup after loading the view.
        print("Movie Details ------>",self.presenter?.interactor?.getMoviesDetails(movie: self.movie!))
        print("Movie Review ------>",self.presenter?.interactor?.getMoviesReviewDetails(movie: self.movie!))
        print("Movie Similar ------>",self.presenter?.interactor?.getSimilarMovieDetails(movie: self.movie!, page: 1))
        print("Movie Cast ------>",self.presenter?.interactor?.getCaseCrewMovieDetails(movie: self.movie!))
    }
    fileprivate func setup(){
        self.cofigureTableView()
    }
    private func cofigureTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UINib(nibName: MovieDetailHeaderTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MovieDetailHeaderTableViewCell.cellIdentifier)
        self.tableView.register(UINib(nibName: MovieDetailCrewTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MovieDetailCrewTableViewCell.cellIdentifier)
        self.tableView.register(UINib(nibName: MovieReviewTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MovieReviewTableViewCell.cellIdentifier)
        self.tableView.register(UINib(nibName: SimilarMovieTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: SimilarMovieTableViewCell.cellIdentifier)
        
        self.tableView.estimatedRowHeight = 120.0
        
       
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
extension MovieDetailsViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 { //Movie Header Details
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailHeaderTableViewCell.cellIdentifier, for: indexPath) as? MovieDetailHeaderTableViewCell else { return UITableViewCell() }
            if let currentMovieDetails = self.currentMovieDetails{
                cell.configureCurrentMovieDetails(movieResult: currentMovieDetails)
            }
            return cell
        }else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailCrewTableViewCell.cellIdentifier, for: indexPath) as? MovieDetailCrewTableViewCell else { return UITableViewCell() }
            if let currentMovieDetails = self.currentCastCrewDetails{
                cell.configureCurrentMovieDetails(movieResult: currentMovieDetails)
            }
            return cell
        }else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieReviewTableViewCell.cellIdentifier, for: indexPath) as? MovieReviewTableViewCell else { return UITableViewCell() }
            if let currentMovieDetails = self.currentReviewDetail{
                cell.configureCurrentCellDetails(review: currentMovieDetails)
            }
            cell.delegate = self
            return cell
        }else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilarMovieTableViewCell.cellIdentifier, for: indexPath) as? SimilarMovieTableViewCell else { return UITableViewCell() }
            if let currentMovieDetails = self.currentSimilarResults{
                cell.configureCurrentMovieDetails(movieResult: currentMovieDetails)
            }
            return cell
        }else{
            return UITableViewCell()
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        }else if indexPath.row == 1{
            return 500
        }else if indexPath.row == 3{
            return 250
        }else{
            return UITableView.automaticDimension
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
extension MovieDetailsViewController:MoviewReviewDelegate{
    func viewAllReviewSelector() {
        
    }
}
extension MovieDetailsViewController:MovieDetailView{
    func updatewithSimilarMovie(movie: SimilarMovieBase) {
        DispatchQueue.main.async {
            self.currentSimilarResults = movie
            self.tableView.reloadData()
        }
    }
    
    func updatewithMovieCast(movie: MovieCaseCrewBase) {
        DispatchQueue.main.async {
            self.currentCastCrewDetails = movie
            self.tableView.reloadData()
        }
    }
    
    func updatewithMovieReview(movie: MovieReviewBase) {
        DispatchQueue.main.async {
            self.currentReviewDetail = movie
            self.tableView.reloadData()
        }
    }
    
    
    func update(with error: String) {
        
    }
    
    func updatewithMovieDetails(movie: MovieDetailDataBase) {
        DispatchQueue.main.async {
            self.currentMovieDetails = movie
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func buttonBackSelector(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
