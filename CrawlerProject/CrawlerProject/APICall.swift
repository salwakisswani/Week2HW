//
//  APICall.swift
//  DataTypeProject
//
//  Created by Salwa Kisswani on 7/8/19.
//  Copyright © 2019 Salwa Kisswani. All rights reserved.
//

import Foundation
import UIKit

struct APICall {
    
    static let shared = APICall()
    let base_url = "https://anapioficeandfire.com/api"
    
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
        
        func fetchData(completion: @escaping(Result<[DataType], Error>) -> Void, {
            guard let url = URL(string: base_url) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
            completion(.failure(error))
            return
            }
            
            // parse data
            guard let data = data?(removeString: "null,") else { return }
            
            // decode data
            do {
            let dataType = try JSONDecoder().decode([DataType].self, from: data)
            completion(.success(dataType))
            } catch let error {
            completion(.failure(error))
            }
            
            }.resume()
            
        }
        
        func fetchData(completion: @escaping([DataType]?, Error?) -> ()) {
            guard let url = URL(string: base_url) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                // handle error
                if let error = error {
                    print("Failed to fetch data with error: ", error)
                    completion(nil, error)
                    return
                }
                
                // parse data
                guard let data = data?.parseData(removeString: "null,") else { return }
                
                // decode data
                do {
                    let dataType = try JSONDecoder().decode([DataType].self, from: data)
                    print(dataType[0] as Any)
                    completion(dataType, nil)
                } catch let error {
                    print("Failed to create json with error: ", error.localizedDescription)
                    completion(nil, error)
                }
                
                }.resume()
        }
    }
    
    extension Data {
        func parseData(removeString string: String) -> Data? {
            let dataAsString = String(data: self, encoding: .utf8)
            let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
            guard let data = parsedDataString?.data(using: .utf8) else { return nil }
            return data
        }
    }
}

func fetchDataType() {
    
    APICall.shared.fetchData { (result) in
        switch result {
        case .success(let dataType):
            self.dataType = dataType
        case .failure(let error):
            print("DEBUG: Failed with error \(error)")
        }
    }
    
}
