//
//  CustomAlert.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 12/5/21.
//


import UIKit


class CustomAlertView: UIView, Modal {
    
    
    static let instance = CustomAlertView()

    
    let parentView = UIView()
    
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Post", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        return button
    }()
    
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .systemGray2
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        return button
    }()
    
     var backgroundView = UIView()
     var dialogView = UIView()
    
    
    convenience init(title:String) {
         self.init(frame: UIScreen.main.bounds)

    }
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        self.backgroundView.frame = frame
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.6
        self.addSubview(backgroundView)
        self.addSubview(self.cancelButton)
        self.addSubview(self.postButton)
        self.addSubview(self.parentView)
        
        
        
        self.cancelButton.addTarget(self, action: #selector(self.cancel), for: .touchUpInside)
        self.postButton.addTarget(self, action: #selector(self.post), for: .touchUpInside)

        
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
    }
    
    
    func showAlert() {
           UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    
    @objc func cancel() {
        self.dismiss(animated: true)
    }
    
    
    @objc func post() {
        print("Posted!")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    


    
    
    
}

