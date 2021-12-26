//
//  SpinnerViewController.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/28/21.
//

import UIKit

class SpinnerViewController: UIViewController {
    
    
    var spinner = UIActivityIndicatorView(style: .large)
    

    override func loadView() {
        
        
        self.view = UIView()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        self.spinner.color = .systemBlue
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.startAnimating()
        self.view.addSubview(spinner)
        self.spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
    }
    
    
}

