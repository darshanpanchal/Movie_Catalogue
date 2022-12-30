//
//  MovieListTableViewCell.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "MovieListTableViewCell"
    static let xibName = "MovieListTableViewCell"
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var imgMovie:UIImageView!
    @IBOutlet weak var lblMovieName:UILabel!
    @IBOutlet weak var lblMovieDate:UILabel!
    @IBOutlet weak var lblMovieLike:UILabel!
    @IBOutlet weak var lblMovieRate:UILabel!
    
    
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
        self.lblMovieDate.text = "\(movieResult.release_date ?? "")"
        self.lblMovieName.text = "\(movieResult.title ?? "")"
        self.lblMovieLike.text = "\(movieResult.vote_count ?? 0)"
        self.lblMovieRate.text = "\(movieResult.vote_average ?? 0.0)"
    }
    
}
