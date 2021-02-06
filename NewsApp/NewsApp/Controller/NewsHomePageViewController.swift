//
//  NewsHomePageViewController.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//

import UIKit

class NewsHomePageViewController: BaseViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    lazy var viewModel = NewsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDetails()
    }
    
    fileprivate func setupUI() {
        homeCollectionView.register(NibFiles.TopNewsCollectionViewCell.instance, forCellWithReuseIdentifier: TopNewsCollectionViewCell.identifier)
        homeCollectionView.register(NibFiles.PopularNewsHeadingCollectionViewCell.instance, forCellWithReuseIdentifier: PopularNewsHeadingCollectionViewCell.identifier)
        homeCollectionView.register(NibFiles.PopularNewsCollectionViewCell.instance, forCellWithReuseIdentifier: PopularNewsCollectionViewCell.identifier)
        homeCollectionView.register(NibFiles.BottomBannerCollectionViewCell.instance, forCellWithReuseIdentifier: BottomBannerCollectionViewCell.identifier)
        
    }
    
    fileprivate func fetchDetails() {
        viewModel.fetchNewsHeadlines()
    }
    
    //MARK:- BaseViewController  methods
    override func viewModelObject() -> BaseViewModel? {
        return viewModel
    }
    
    override func setUpViewModelCallbacks() {
        super.setUpViewModelCallbacks()
        
        let viewModel = viewModelObject() as! NewsViewModel
        
        viewModel.requestSucceeded = {  [weak self] in
            guard let self = self else {return}
            self.homeCollectionView.reloadData()
        }
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
        self.showBookMarkScreen()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        self.showSearchScreen()
    }
    
}

//MARK:- CollectionView Delegate / dataSource methods

extension NewsHomePageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.sectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewModel.cellIndexes[section] == .popularNews {
            return self.viewModel.articleCount
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.bounds.width
        let cellType = self.viewModel.cellIndexes[indexPath.section]
        switch cellType {
        
        case .topNews:   return CGSize(width: viewWidth, height:(UIScreen.main.bounds.size.height * 0.7))
          
        case .popularNewsHeading:  return CGSize(width: collectionView.bounds.width, height: MarginConstants.headerHeight)
           
        case .popularNews:  return CGSize(width: collectionView.bounds.width, height: MarginConstants.itemHeight)
           
        case .bottombanner: return CGSize(width: collectionView.bounds.width, height: MarginConstants.bottomBannerheight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = self.viewModel.cellIndexes[indexPath.section]
        switch cellType {
        case .topNews:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopNewsCollectionViewCell.identifier, for: indexPath) as? TopNewsCollectionViewCell {
                cell.configureData(self.viewModel.topNewsItem)
                return cell
            }
            else { return UICollectionViewCell() }
        case .popularNewsHeading:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularNewsHeadingCollectionViewCell.identifier, for: indexPath) as? PopularNewsHeadingCollectionViewCell {
                return cell
            }
            else { return UICollectionViewCell() }
        case .popularNews:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularNewsCollectionViewCell.identifier, for: indexPath) as? PopularNewsCollectionViewCell {
                cell.configureData(self.viewModel.itemAt(indexPath.row))
                return cell
            }
            else { return UICollectionViewCell() }
        case .bottombanner:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomBannerCollectionViewCell.identifier, for: indexPath) as? BottomBannerCollectionViewCell {
                return cell
            }
            else { return UICollectionViewCell() }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellType = self.viewModel.cellIndexes[indexPath.section]
        
        switch cellType {
        
        case .topNews: self.showArticleDetails(self.viewModel.topNewsItem)
            
        case .popularNewsHeading,.bottombanner: return
            
        case .popularNews: self.showArticleDetails(self.viewModel.itemAt(indexPath.row))
            
        }
    }
    
}
 
//MARK: - Navigation methods

extension NewsHomePageViewController {
    func showArticleDetails(_ article: Displayable) {
        let newDetailsVC = Storyboards.Main.instantiateVC(NewsDetailsViewController.self)
        newDetailsVC.articleDetails = article
        self.navigationController?.pushViewController(newDetailsVC, animated: true)
    }
    
    func showBookMarkScreen() {
        let newDetailsVC = Storyboards.Main.instantiateVC(BookMarkViewController.self)
        self.navigationController?.pushViewController(newDetailsVC, animated: true)
    }
    
    func showSearchScreen() {
        let newDetailsVC = Storyboards.Main.instantiateVC(SearchResultsViewController.self)
        self.navigationController?.pushViewController(newDetailsVC, animated: true)
    }
}
