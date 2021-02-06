//
//  SearchResultsViewController.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import UIKit

class SearchResultsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
