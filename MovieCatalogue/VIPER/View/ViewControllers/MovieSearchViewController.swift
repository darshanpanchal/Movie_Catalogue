//
//  MovieSearchViewController.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import UIKit

class MovieSearchViewController: UIViewController {

    
    @IBOutlet weak var buttonBack:UIButton!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet var objsearchBar:UITextField!

    var currentPage:Int = 1
    var isLoadMore:Bool = false
    var currentSearchText:String = ""
    
    //VIPER
    var presenter:MovieSearchPresenter?
    
    var arrayOfMovies:[MovieResults] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setup()
        //self.getSearchMovieAPIRequest()
    }
    func setup(){
        
        self.objsearchBar.delegate = self
        self.cofigureTableView()
    }
    func cofigureTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UINib(nibName: MovieSearchTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: MovieSearchTableViewCell.cellIdentifier)
        self.tableView.estimatedRowHeight = 120.0
        

        
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension MovieSearchViewController:UITextFieldDelegate{
    
   
      func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
          return true
      }
      func textFieldShouldClear(_ textField: UITextField) -> Bool {
          self.currentPage = 1
          self.currentSearchText = ""
          self.getSearchMovieAPIRequest()
          return true
      }
      func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
          
          return true
      }
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let text: NSString = (textField.text ?? "") as NSString
            let resultString = text.replacingCharacters(in: range, with: string)
          self.currentPage = 1
          self.currentSearchText = resultString ?? ""
          self.getSearchMovieAPIRequest()
          return true
      }
     
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.currentPage = 1
        self.currentSearchText = ""
        self.getSearchMovieAPIRequest()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        self.currentPage = 1
        self.currentSearchText = searchText
        //self.getSearchMovieAPIRequest()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        self.currentPage = 1
        self.currentSearchText = searchBar.text ?? ""
        //self.getSearchMovieAPIRequest()
    }
    func getSearchMovieAPIRequest(){
        //self.presenter?.interactor?.getMoviesSearchDetails(curentpage: self.currentPage, searchString: self.currentSearchText)
    }
}
extension MovieSearchViewController:MovieSearchView{
   
    
    @IBAction func buttonBackSelector(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func updatewithMovieSearchDetails(movies: [MovieResults]) {
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
extension MovieSearchViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.cellIdentifier, for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell() }
        cell.configureCurrentMovieDetails(movieResult: self.arrayOfMovies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0//UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToMovieDetailViewController(movie: self.arrayOfMovies[indexPath.row])
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !self.isLoadMore){
              self.isLoadMore = true
              self.currentPage += 1
              print("self.currentPage---->", self.currentPage)
             self.presenter?.interactor?.getMoviesSearchDetails(curentpage: self.currentPage, searchString: self.currentSearchText)
             }
         }
    func navigateToMovieDetailViewController(movie:MovieResults){
        let router = MovieListRouter.loadMovieDetails()
        if let rootViewController:MovieDetailsViewController = router.entrydetail as? MovieDetailsViewController{
            rootViewController.movie = movie
            self.navigationController?.pushViewController(rootViewController, animated: true)
        }
    }
}
