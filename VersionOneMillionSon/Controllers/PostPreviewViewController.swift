//
//  PostPreviewViewController.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/27/21.
//


import UIKit


class PostPreviewViewController: UIViewController {
        
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.id)
        table.register(PostDescTableViewCell.self, forCellReuseIdentifier: PostDescTableViewCell.id)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        table.backgroundColor = .systemBackground
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Post Preview"
        self.view.addSubview(self.table)
        self.table.delegate = self
        self.table.dataSource = self
        self.table.separatorStyle = .none
        
        
        let post = UIBarButtonItem(title: "Post", style: .done, target: self, action: #selector(self.showPostAlert))
        self.navigationItem.rightBarButtonItem = post
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.table.frame = self.view.bounds
    }
    
    
    
    @objc func showPostAlert() {
        let vc = AlertViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    

}


extension PostPreviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 480
        case 2:
            return UITableView.automaticDimension
        default:
            return 80
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.id,
                                                           for: indexPath) as? CollectionTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            cell.textLabel?.text = UserDefaults.standard.string(forKey: "TempTitle")
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostDescTableViewCell.id,
                                                           for: indexPath) as? PostDescTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
            return cell
            
        }
        
    
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

