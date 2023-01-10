//
//  MovieListViewController.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var buttonSearch:UIButton!
    
    var currentPage:Int = 1
    var isLoadMore:Bool = false
    
    //VIPER
    var presenter:MoviePresenter?
    
    var arrayOfMovies:[MovieResults] = []
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //SetUp Movie List
        self.setup()
    }
    // MARK: - Setup
    func setup(){
        self.cofigureTableView()
    }
    func cofigureTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UINib(nibName: MovieListTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MovieListTableViewCell.cellIdentifier)
        self.tableView.estimatedRowHeight = 120.0
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        if let currentinteractor = self.presenter?.interactor{
            currentinteractor.getMoviesList(curentpage: 1)
        }
        self.refreshControl.endRefreshing()

    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    func navigateToMovieDetailViewController(movie:MovieResults){
        let router = MovieListRouter.loadMovieDetails()
        if let rootViewController:MovieDetailsViewController = router.entrydetail as? MovieDetailsViewController{
            rootViewController.movie = movie
            self.navigationController?.pushViewController(rootViewController, animated: true)
        }
    }
    func navigationToMovieSearchViewContoller(){
        let router = MovieListRouter.loadMovieSearch()
        if let moviesearchViewConrolller:MovieSearchViewController = router.entrySearch as? MovieSearchViewController{
            self.navigationController?.pushViewController(moviesearchViewConrolller, animated: true)
        }
    }
    @IBAction func buttonSearchSelector(sender:UIButton){
        self.navigationToMovieSearchViewContoller()
    }
}
extension MovieListViewController:MovieView{
    func update(with movies: [MovieResults]) {
        DispatchQueue.main.async {
            if movies.count > 0 {
                self.isLoadMore = false
            }else{
                self.isLoadMore = true
            }
            if self.currentPage == 1{
                self.arrayOfMovies = movies
            }else{
                self.arrayOfMovies.append(contentsOf: movies)
            }
            self.tableView.reloadData()
        }
    }
    func update(with error: String) {
       
        self.isLoadMore = true
    }
    
}
extension MovieListViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.cellIdentifier, for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }
        cell.configureCurrentMovieDetails(movieResult: self.arrayOfMovies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToMovieDetailViewController(movie: self.arrayOfMovies[indexPath.row])
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !self.isLoadMore){
              self.isLoadMore = true
              self.currentPage += 1
              print("self.currentPage---->", self.currentPage)
              self.presenter?.interactor?.getMoviesList(curentpage: self.currentPage)
             }
         }
}
