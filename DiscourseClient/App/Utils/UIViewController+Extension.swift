//
//  UIViewController+Extension.swift
//  DiscourseClient
//
//  Created by Ramón Menor Molina on 30/7/21.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionTitle: String = "Ok") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // Añade un loader al que se le puede llamar
    func showLoader() {
        let loaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        loaderView.tag = 387
        loaderView.backgroundColor = .white
        
        let loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        loader.center = loaderView.center
        loader.style = .large
        loader.color = .black
        loader.startAnimating()
        
        loaderView.addSubview(loader)
        view.addSubview(loaderView)
    }
    
    func hideLoader() {
        view.viewWithTag(387)?.removeFromSuperview()
    }
}
