//
//  PopularNewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import UIKit
import Kingfisher
class PopularNewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var popularImageView: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!
    var data: Displayable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureData(_ data: Displayable) {
        self.data = data
        self.sourceLabel.text  = data.articleSource
        self.headlineLabel.text = data.articleTitle
        self.descriptionLabel.text = data.articleSubTitle
        if let url = URL(string: data.articleImageURL) {
            popularImageView.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
        else {
            self.popularImageView.image = UIImage(named: "placeholder")
        }
    }
    @IBAction func bookMarkTapped(_ sender: UIButton) {
        BookmarkManager.shared.add(self.data!)
    }
    
}
