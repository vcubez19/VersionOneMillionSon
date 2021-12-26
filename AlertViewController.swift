//
//  AlertViewController.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 12/5/21.
//


import UIKit


class AlertViewController: UIViewController {
    
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 30.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .systemGray2
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        return button
    }()
    
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.view.addSubview(self.container)
        self.container.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.postButton)
        self.stackView.addArrangedSubview(self.cancelButton)

        
        
        self.container.layer.masksToBounds = true
        self.container.layer.cornerRadius = 20.0
        
        
        self.cancelButton.addTarget(self, action: #selector(self.cancel), for: .touchUpInside)
        self.postButton.addTarget(self, action: #selector(self.post), for: .touchUpInside)

        
        let constraints: [ NSLayoutConstraint ] = [
            self.container.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor),
            self.container.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor),
            self.container.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor, constant: 40.0),
            self.container.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor, constant: -40.0),
            self.container.heightAnchor.constraint(equalToConstant: 200.0),
            self.stackView.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20.0),
            self.stackView.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20.0),

            self.stackView.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 30.0),
            self.stackView.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -30.0),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 50.0),
            self.postButton.heightAnchor.constraint(equalToConstant: 50.0)

        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func post() {
        print("Posted!")
    }
    

}

