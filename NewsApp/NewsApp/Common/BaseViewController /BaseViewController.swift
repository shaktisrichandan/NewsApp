//
//  BaseViewController.swift
//  NewsApp
//
//  Created by Shakti Prakash  on 06/02/21.
//
import UIKit


class BaseViewController: UIViewController {
    lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
         setupActivityIndicator()
         setUpViewModelCallbacks()
    }
    
    
    func startActivityIndicator() {
       activityIndicator.startAnimating()
     }
     
     func stopActivityIndicator() {
       activityIndicator.stopAnimating()
     }
    
    
    
    fileprivate func setupActivityIndicator() {
        activityIndicator.color = .red
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK:   Must be overridden by subclasses to return a valid view model object.
    func viewModelObject() -> BaseViewModel? {
      return nil
    }
    
    //  Must be overridden by subclasses for callback setup
    func setUpViewModelCallbacks() {
      
      self.viewModelObject()?.requestStatusChanged = { [weak self] inProgress in
        inProgress ? self?.startActivityIndicator() : self?.stopActivityIndicator()
      }
      
      self.viewModelObject()?.requestEncounteredError = { [weak self] error in
        self?.showAlertWith(error: error)
      }
    }
    
    
    
    public func showAlertWith(error: Error?) {
      if error == nil {
        return
      }
      else if let e = error as? NAError {
        AlertManager.showAlert(on: self, withTitle: e.title, message: e.localizedDescription)
      }
      else {
        AlertManager.showAlert(on: self, withTitle: error?.localizedDescription ?? "", message: nil)
      }
    }
    
}
