//
//  ViewController.swift
//  DataTypeProject
//
//  Created by Salwa Kisswani on 7/8/19.
//  Copyright © 2019 Salwa Kisswani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var dataTypeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataTypeTableView.dataSource = self as! UITableViewDataSource
        dataTypeTableView.delegate = self as! UITableViewDelegate
        dataTypeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        guard let url = URL(string: base_url) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            let jsonObject = try! JSONSerialization.jsonObject(with: data, options: [])
            if let jsonDictionary = jsonObject as? [String: Any] {
                self?.jsonDictionary = jsonDictionary
            } else if let jsonArray = jsonObject as? [Any] {
                self?.jsonArray = jsonArray
            }
            DispatchQueue.main.async {
                self?.dataTypeTableView.reloadData()
            }
            }.resume()
    }
}

