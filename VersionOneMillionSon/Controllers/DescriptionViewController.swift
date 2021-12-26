//
//  StepTwoViewController.swift
//  TestingNew
//
//  Created by Vincent Cubit on 11/21/21.
//


import UIKit


class DescriptionViewController: UIViewController, UITextViewDelegate {
    
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(TextViewTableViewCell.self, forCellReuseIdentifier: TextViewTableViewCell.id)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        return table
    }()
    
    
    
    private let doneButton = UIBarButtonItem(systemItem: .done)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.addSubview(self.table)
        self.table.delegate = self
        self.table.dataSource = self
        self.doneButton.target = self
        self.doneButton.action = #selector(self.done)
        self.navigationItem.rightBarButtonItem = self.doneButton
        self.table.keyboardDismissMode = .interactive
        
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.table.frame = self.view.bounds
    }
    
    
    @objc func done() {
            self.view.endEditing(true)
    }
    
    
}


extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Description (Optional)"
        } else {
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.id,
                                                           for: indexPath) as? TextViewTableViewCell else { return UITableViewCell() }

            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.textLabel?.text = "Next"
            cell.textLabel?.textColor = .white
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .systemBlue
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 20.0
            return cell
        }
   
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.view.frame.height / 2
        default:
            return 70
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = PostPreviewViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
}

