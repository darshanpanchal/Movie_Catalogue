//
//  MovieDetailsViewController.swift
//  MovieCatalogue
//
//  Created by Darshan on 29/12/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var buttonBack:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
extension MovieDetailsViewController{
    @IBAction func buttonBackSelector(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
