//
//  TextViewTableViewCell.swift
//  TestingNew
//
//  Created by Vincent Cubit on 11/21/21.
//


import UIKit


class TextViewTableViewCell: UITableViewCell, UITextViewDelegate {
    
    
    static let id = "TextViewTableViewCell"
    
    
     private let textView: UITextView = {
        let textView = UITextView()
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        return textView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.textView)
        self.textView.delegate = self
        self.textView.text = UserDefaults.standard.string(forKey: "TempDescription")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textView.frame = self.contentView.bounds

    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if let text = textView.text {
            UserDefaults.standard.setValue(text, forKey: "TempDescription")
        }
    }
    

}

