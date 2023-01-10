//
//  MovieSearchTableViewCell.swift
//  MovieCatalogue
//
//  Created by Darshan on 10/01/23.
//

import UIKit
import SDWebImage

class MovieSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMovieName:UILabel!
    @IBOutlet weak var imgMovie:UIImageView!
    @IBOutlet weak var containerView:UIView!
    static let cellIdentifier = "MovieSearchTableViewCell"
    static let xibName = "MovieSearchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.addShadow()
    }
    func addShadow(){
        self.containerView.layer.cornerRadius = 6.0
        self.containerView.layer.shadowColor = UIColor.darkGray.cgColor
        self.containerView.layer.shadowOpacity = 0.3
        self.containerView.layer.shadowOffset = CGSize.zero
        self.containerView.layer.shadowRadius = 6.0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCurrentMovieDetails(movieResult:MovieResults){
        let imageURl = "\(Constant.kImageURL)\(movieResult.poster_path ?? "")"
        self.imgMovie.sd_setImage(with: URL(string: "\(imageURl)"), placeholderImage: UIImage(named: "placeholder.png"))
        self.lblMovieName.text = "\(movieResult.title ?? "")"
    }
}
