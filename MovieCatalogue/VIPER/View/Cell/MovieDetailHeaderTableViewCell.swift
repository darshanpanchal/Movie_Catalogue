//
//  MovieDetailHeaderTableViewCell.swift
//  MovieCatalogue
//
//  Created by Darshan on 09/01/23.
//

import UIKit
import SDWebImage

class MovieDetailHeaderTableViewCell: UITableViewCell {
    
    
    static let cellIdentifier = "MovieDetailHeaderTableViewCell"
    static let xibName = "MovieDetailHeaderTableViewCell"
    
    @IBOutlet weak var imageBackgroundPoster:UIImageView!
    @IBOutlet weak var imagePoster:UIImageView!
    @IBOutlet weak var lblMovieName:UILabel!
    @IBOutlet weak var lblMovieRating:UILabel!
    @IBOutlet weak var lblMovieDate:UILabel!
    @IBOutlet weak var lblMovieTime:UILabel!
    @IBOutlet weak var lblMovieTag:UILabel!
    @IBOutlet weak var lblMovieDetails:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.addShadow()
    }
    func addShadow(){
        self.imagePoster.layer.borderColor = UIColor.black.cgColor
        self.imagePoster.layer.borderWidth = 0.8
        self.imagePoster.layer.cornerRadius = 0.0
        self.imagePoster.layer.shadowColor = UIColor.darkGray.cgColor
        self.imagePoster.layer.shadowOpacity = 0.3
        self.imagePoster.layer.shadowOffset = CGSize.zero
        self.imagePoster.layer.shadowRadius = 6.0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCurrentMovieDetails(movieResult:MovieDetailDataBase){
        let imageURl = "\(Constant.kImageURL)\(movieResult.backdrop_path ?? "")"
        let imageposterURl = "\(Constant.kImageURL)\(movieResult.poster_path ?? "")"
        self.imageBackgroundPoster.sd_setImage(with: URL(string: "\(imageURl)"), placeholderImage: UIImage(named: "movie_placeholder.png"))
        self.imagePoster.sd_setImage(with: URL(string: "\(imageposterURl)"), placeholderImage: UIImage(named: "movie_placeholder.png"))
        self.lblMovieName.text = movieResult.title
        let rating = String(format: "%.1f",Float(movieResult.vote_average!))
        self.lblMovieRating.text =  "\(rating)/10"
        self.lblMovieDetails.text = movieResult.overview
        let movieDate =  movieResult.release_date ?? ""
        self.lblMovieDate.text = movieDate.convertDateDDMMMYYYY()
        let hours = self.minutesToHoursAndMinutes(movieResult.runtime ?? 0).0
        let minutes = self.minutesToHoursAndMinutes(movieResult.runtime ?? 0).1
        self.lblMovieTime.text = "\(hours)h \(minutes)m"
        if let arrayValue = movieResult.genres{
            let names = arrayValue.map { $0.name! }
            self.lblMovieTag.text = "\(names.joined(separator: ", "))"
        }
        
    }
    func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int , leftMinutes: Int) {
        return (minutes / 60, (minutes % 60))
    }
}
 
