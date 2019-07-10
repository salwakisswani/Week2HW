//
//  TableViewDelegate .swift
//  DataTypeProject
//
//  Created by Salwa Kisswani on 7/8/19.
//  Copyright © 2019 Salwa Kisswani. All rights reserved.
//

import Foundation
class ViewController: UITableViewDelegate {
    
    var jsonDictionary = [String: Any]()
    var jsonArray = [Any]()
    
    enum DataType {
        case url(value: String)
        case dictionary
        case array(value: [Any], otherThing: Int)
        case string(value: String)
        case number
        case boolean
        case null
        
        func getDataType(for input: Any) -> DataType {
            switch input {
            case is [String: Any]:
                return .dictionary
            case is [Any]:
                return .array
            case is String:
                let stringValue = input as! String
                return !stringValue.contains("http")
                    ? .string(value: stringValue)
                    : .url(value: stringValue)
            case is NSNumber:
                return .number
            case is Bool:
                return .boolean
            case is NSNull:
                return .null
            default:
                print("not working")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        if !jsonDictionary.isEmpty {
            let values = Array(jsonDictionary.values)
            let selectedValue = values[indexPath.row]
            let dataType = DataType.getDataType(for: selectedValue)
            switch dataType {
            case .array:
                nextViewController.base_url = ""
                nextViewController.jsonArray = (selectedValue as? [Any]) ?? []
            case .dictionary:
                nextViewController.base_url = ""
                nextViewController.jsonDictionary = (selectedValue as? [String: Any]) ?? [:]
            case .string, .number, .null, .boolean:
                return
            case .url:
                nextViewController.base_url = (selectedValue as? String) ?? ""
            }
        } else if !jsonArray.isEmpty {
            nextViewController.base_url = ""
            let selectedValue = jsonArray[indexPath.row]
            let dataType = DataType.getDataType(for: selectedValue)
            switch dataType {
            case .array:
                nextViewController.jsonArray = (selectedValue as? [Any]) ?? []
            case .boolean, .null, .string, .number:
                return
            case .dictionary:
                nextViewController.jsonDictionary = (selectedValue as? [String: Any]) ?? [:]
            case .url:
                nextViewController.base_url = (jsonArray[indexPath.row] as? String) ?? ""
            }
        } else {
            
        }
        navigationController?
            .pushViewController(nextViewController,
                                animated: true)
    }
}
