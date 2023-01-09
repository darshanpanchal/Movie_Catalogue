//
//  MovieDetailCrewTableViewCell.swift
//  MovieCatalogue
//
//  Created by Darshan on 09/01/23.
//

import UIKit

class MovieDetailCrewTableViewCell: UITableViewCell {

    @IBOutlet weak var castCollectionView:UICollectionView!
    @IBOutlet weak var crewCollectionView:UICollectionView!
    
    static let cellIdentifier = "MovieDetailCrewTableViewCell"
    static let xibName = "MovieDetailCrewTableViewCell"
    
    
    var arrayCurrentCast:[MovieCast]?
    var arrayCurrentCrew:[MovieCrew]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.configureCollectionView()
        
    }
    func configureCollectionView(){
        self.castCollectionView.delegate = self
        self.castCollectionView.dataSource = self
        self.castCollectionView.register(UINib(nibName: MovieCastCollectionViewCell.xibName, bundle: nil), forCellWithReuseIdentifier: MovieCastCollectionViewCell.cellIdentifier)
        
        self.crewCollectionView.delegate = self
        self.crewCollectionView.dataSource = self
        self.crewCollectionView.register(UINib(nibName: MovieCastCollectionViewCell.xibName, bundle: nil), forCellWithReuseIdentifier: MovieCastCollectionViewCell.cellIdentifier)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCurrentMovieDetails(movieResult:MovieCaseCrewBase){
        DispatchQueue.main.async {
            self.arrayCurrentCast = movieResult.cast
            self.arrayCurrentCrew = movieResult.crew
            self.castCollectionView.reloadData()
            self.crewCollectionView.reloadData()
        }
    }
}
extension MovieDetailCrewTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.castCollectionView{
            return self.arrayCurrentCast?.count ?? 0
        }else if collectionView == self.crewCollectionView{
            return self.arrayCurrentCrew?.count ?? 0
        }else{
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let unwrappedCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCastCollectionViewCell else {
            return UICollectionViewCell()
        }
        if collectionView == self.castCollectionView{
            if let arrayOfCast = self.arrayCurrentCast{
                unwrappedCell.configureCurrentCastDetail(currentCast: arrayOfCast[indexPath.row])
            }
            return unwrappedCell
        }else if collectionView == self.crewCollectionView{
            if let arrayOfCrew = self.arrayCurrentCrew{
                unwrappedCell.configureCurrentCrewDetail(currentCrew: arrayOfCrew[indexPath.row])
            }
            return unwrappedCell
        }else{
            return UICollectionViewCell()
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2.5, height: collectionView.bounds.height)
    }

}
