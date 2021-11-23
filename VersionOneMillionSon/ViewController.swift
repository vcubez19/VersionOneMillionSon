//
//  ViewController.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/23/21.
//


import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Title"
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Title"
        field.borderStyle = .roundedRect
        field.returnKeyType = .done
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.clearButtonMode = .whileEditing
        field.enablesReturnKeyAutomatically = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        return button
    }()

        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New post"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.textField)
        self.view.addSubview(self.nextButton)
        self.nextButton.addTarget(self, action: #selector(self.nextView), for: .touchUpInside)
        self.textField.delegate = self
        
        
        let contraints: [ NSLayoutConstraint ] = [
            self.textField.centerYAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerYAnchor),
            self.textField.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor),
            self.textField.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor, constant: 40),
            self.textField.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor, constant: -40),
            self.textField.heightAnchor.constraint(equalToConstant: 50.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor, constant: 40),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.textField.layoutMarginsGuide.topAnchor, constant: -30),
            self.nextButton.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor, constant: 40),
            self.nextButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -70),
            self.nextButton.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor, constant: -40),
            self.nextButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        NSLayoutConstraint.activate(contraints)
        
        
    }
    
    
    @objc func nextView() {
        let dest = PhotosViewController()
        self.navigationController?.pushViewController(dest, animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.count >= 4 {
            textField.resignFirstResponder()
            self.nextView()
            return true
        } else {
            return false
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

