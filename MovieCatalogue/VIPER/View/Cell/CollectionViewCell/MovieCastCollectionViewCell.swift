//
//  MovieCastCollectionViewCell.swift
//  MovieCatalogue
//
//  Created by Darshan on 09/01/23.
//

import UIKit
import SDWebImage

class MovieCastCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageCastCrew:UIImageView!
    @IBOutlet weak var lblCastCrew:UILabel!
    
    static let cellIdentifier = "MovieCastCollectionViewCell"
    static let xibName = "MovieCastCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        // Initialization code
        self.imageCastCrew.clipsToBounds = true
        self.imageCastCrew.layer.cornerRadius = 15.0

    }
    func configureCurrentCastDetail(currentCast:MovieCast){
        let imageURl = "\(Constant.kImageURL)\(currentCast.profile_path ?? "")"
        self.imageCastCrew.sd_setImage(with: URL(string: "\(imageURl)"), placeholderImage: UIImage(named: "movie_placeholder.png"))
        self.lblCastCrew.text = currentCast.name
    }
    func configureCurrentCrewDetail(currentCrew:MovieCrew){
        let imageURl = "\(Constant.kImageURL)\(currentCrew.profile_path ?? "")"
        self.imageCastCrew.sd_setImage(with: URL(string: "\(imageURl)"), placeholderImage: UIImage(named: "movie_placeholder.png"))
        self.lblCastCrew.text = currentCrew.name
    }
}
