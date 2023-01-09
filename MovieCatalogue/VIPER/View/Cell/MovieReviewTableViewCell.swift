//
//  MovieReviewTableViewCell.swift
//  MovieCatalogue
//
//  Created by Darshan on 09/01/23.
//

import UIKit
import SDWebImage

protocol MoviewReviewDelegate{
    func viewAllReviewSelector()
    
}
class MovieReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAuthorName:UILabel!
    @IBOutlet weak var lblDetail:UILabel!
    @IBOutlet weak var imageAuthor:UIImageView!
    
    static let cellIdentifier = "MovieReviewTableViewCell"
    static let xibName = "MovieReviewTableViewCell"
    
    var delegate:MoviewReviewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.imageAuthor.clipsToBounds = true
        self.imageAuthor.layer.cornerRadius = 20.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     func configureCurrentCellDetails(review:MovieReviewBase){
         let firstAuthor = review.results?[0]
         let path = firstAuthor?.author_details?.avatar_path ?? ""
         let imageURl = "\(Constant.kImageURL)\(path)"
         self.imageAuthor.sd_setImage(with: URL(string: "\(imageURl)"), placeholderImage: UIImage(named: "placeholder.png"))
         self.lblAuthorName.text = firstAuthor?.author_details?.name ?? ""
         self.lblDetail.text = firstAuthor?.content ?? ""
         
    }
    @IBAction func buttonViewAllReviews(sender:UIButton){
        self.delegate?.viewAllReviewSelector()
    }
}
