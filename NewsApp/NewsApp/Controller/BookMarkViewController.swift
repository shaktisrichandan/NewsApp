//
//  BookMarkViewController.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import UIKit

class BookMarkViewController: BaseViewController {
    
    
    @IBOutlet weak var bookMarkCollectionView: UICollectionView!
    
    lazy var viewModel = BookmarkViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bookMarkedarticles()
    }
    
    fileprivate func setupUI() {
        bookMarkCollectionView.register(NibFiles.PopularNewsCollectionViewCell.instance, forCellWithReuseIdentifier: PopularNewsCollectionViewCell.identifier)
    }
    
    fileprivate func bookMarkedarticles() {
        viewModel.fetchBookmarkedarticle()
    }
    
    //MARK:- BaseViewController  methods
    override func viewModelObject() -> BaseViewModel? {
        return viewModel
    }
    
    override func setUpViewModelCallbacks() {
        super.setUpViewModelCallbacks()
        
        let viewModel = viewModelObject() as! BookmarkViewModel
        
        viewModel.requestSucceeded = {  [weak self] in
            guard let self = self else {return}
            self.bookMarkCollectionView.reloadData()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- CollectionView Delegate and  DataSource methods
extension BookMarkViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.itemCount
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: MarginConstants.itemHeight)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularNewsCollectionViewCell.identifier, for: indexPath) as? PopularNewsCollectionViewCell {
            cell.configureData(self.viewModel.itemAt(indexPath.row))
            return cell
        }
        else { return UICollectionViewCell() }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.showArticleDetails(self.viewModel.itemAt(indexPath.row))
        
    }
    
    
}


extension BookMarkViewController {
    func showArticleDetails(_ article: Displayable) {
        let newDetailsVC = Storyboards.Main.instantiateVC(NewsDetailsViewController.self)
        newDetailsVC.articleDetails = article
        self.navigationController?.pushViewController(newDetailsVC, animated: true)
    }
}

