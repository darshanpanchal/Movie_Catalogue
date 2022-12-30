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
    
    //VIPER
    var presenter:MoviePresenter?
    
    var arrayOfMovies:[MovieResults] = []
    
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
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    @IBAction func buttonSearchSelector(sender:UIButton){
        
    }
}
extension MovieListViewController:MovieView{
    func update(with movies: [MovieResults]) {
        DispatchQueue.main.async {
            self.arrayOfMovies = movies
            self.tableView.reloadData()
        }
    }
    func update(with error: String) {
        
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
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
