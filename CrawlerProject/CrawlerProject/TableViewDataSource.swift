//
//  TableViewDataSource.swift
//  DataTypeProject
//
//  Created by Salwa Kisswani on 7/8/19.
//  Copyright © 2019 Salwa Kisswani. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UITableViewDataSource {
    func isEqual(_ object: Any?) -> Bool {
        var description: String
        
        
        var jsonDictionary = [String: Any]()
        var jsonArray = [Any]()
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if !jsonDictionary.isEmpty {
                return jsonDictionary.count
            } else if !jsonArray.isEmpty {
                return jsonArray.count
            } else {
                return 0
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            if !jsonDictionary.isEmpty {
                let keys = Array(jsonDictionary.keys)
                let values = Array(jsonDictionary.values)
                let selectedValue = values[indexPath.row]
                let dataType = DataType.getDataType(for: selectedValue)
                
                cell.textLabel?.text = keys[indexPath.row]
                
                let detailString: String
                switch dataType {
                case .array(let arrayValue):
                    let numberOfItems = (selectedValue as? [Any])?.count ?? 0
                    detailString = "Number of elements: \(numberOfItems)"
                case .dictionary:
                    let numberOfKeys = (selectedValue as? [String: Any])?.count ?? 0
                    detailString = "Number of entries: \(numberOfKeys)"
                case .null:
                    detailString = "NULL"
                case .number, .boolean:
                    detailString = "\(selectedValue)"
                case .string, .url:
                    detailString = (selectedValue as? String) ?? ""
                }
                cell.detailTextLabel?.text = detailString.isEmpty
                    ? "Empty String"
                    : detailString
            } else if !jsonArray.isEmpty {
                let selectedValue = jsonArray[indexPath.row]
                let dataType = DataType.getDataType(for: selectedValue)
                switch dataType {
                case .array:
                    cell.textLabel?.text = "Index: \(indexPath.row)"
                case .dictionary:
                    cell.textLabel?.text = "Entry: \(indexPath.row)"
                case .string, .null, .number, .boolean, .url:
                    let textString = (selectedValue as? String) ?? ""
                    cell.textLabel?.text = textString.isEmpty
                        ? "Empty String"
                        : textString
                }
                cell.detailTextLabel?.text = (selectedValue as? String) ?? ""
            } else {
                cell.textLabel?.text = "Go Back"
            }
            return cell
        }
    }
}
