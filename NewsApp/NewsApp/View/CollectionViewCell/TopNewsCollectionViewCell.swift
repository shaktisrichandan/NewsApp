//
//  TopNewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import UIKit
import Kingfisher
class TopNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sourcelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    var data: Displayable?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(_ data: Displayable) {
        self.data = data
        self.sourcelabel.text  = data.articleSource
        self.titleLabel.text = data.articleTitle
        self.descriptionLabel.text = data.articleSubTitle
        self.imageHeightConstraint.constant = UIScreen.main.bounds.size.height * 0.3
        if let url = URL(string: data.articleImageURL) {
            topImageView.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
        else {
            self.topImageView.image = UIImage(named: "placeholder")
        }
      
     
    }

    @IBAction func bookMarkTapped(_ sender: UIButton) {
        BookmarkManager.shared.add(self.data!)
    }
}
