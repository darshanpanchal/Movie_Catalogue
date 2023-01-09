//
//  SimilarMovieTableViewCell.swift
//  MovieCatalogue
//
//  Created by Darshan on 09/01/23.
//

import UIKit

class SimilarMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView:UICollectionView!
    
    static let cellIdentifier = "SimilarMovieTableViewCell"
    static let xibName = "SimilarMovieTableViewCell"
    
    var arrayOfSimilarMovie:[SimilarMovieResults]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.configureCollectionView()
    }
    func configureCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: SimilarMovieCollectionViewCell.xibName, bundle: nil), forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.cellIdentifier)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCurrentMovieDetails(movieResult:SimilarMovieBase){
        DispatchQueue.main.async {
            self.arrayOfSimilarMovie = movieResult.results
            self.collectionView.reloadData()
        }
    }
}
extension SimilarMovieTableViewCell:UICollectionViewDelegate, UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return self.arrayOfSimilarMovie?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let unwrappedCell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.cellIdentifier, for: indexPath) as? SimilarMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
            if let arrayOfSimilarMovie = self.arrayOfSimilarMovie{
                unwrappedCell.configureCurrentMovieDetail(currentMovie: arrayOfSimilarMovie[indexPath.row])
            }
            return unwrappedCell
      
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2.5, height: collectionView.bounds.height)
    }

}
