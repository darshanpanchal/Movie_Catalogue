//
//  SimilarMovieCollectionViewCell.swift
//  MovieCatalogue
//
//  Created by Darshan on 09/01/23.
//

import UIKit
import SDWebImage

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMovie:UIImageView!
    @IBOutlet weak var lblMovieName:UILabel!
    
    static let cellIdentifier = "SimilarMovieCollectionViewCell"
    static let xibName = "SimilarMovieCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCurrentMovieDetail(currentMovie:SimilarMovieResults){
        let imageURl = "\(Constant.kImageURL)\(currentMovie.poster_path ?? "")"
        self.imageMovie.sd_setImage(with: URL(string: "\(imageURl)"), placeholderImage: UIImage(named: "movie_placeholder.png"))
        self.lblMovieName.text = currentMovie.title ?? ""
    }
}
