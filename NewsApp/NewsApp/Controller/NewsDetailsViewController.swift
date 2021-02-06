//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import UIKit
import WebKit
class NewsDetailsViewController: UIViewController {
    //MARK:- properties
    
    @IBOutlet weak var articledetailsWebview: WKWebView!
    @IBOutlet weak var headerLabel: UILabel!
    var articleDetails: Displayable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        self.headerLabel.text = articleDetails?.articleLink ?? SpacingConstants.emptyString
        if let url  = URL(string:articleDetails?.articleLink ?? SpacingConstants.emptyString) {
            articledetailsWebview.load(URLRequest(url: url))
        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
