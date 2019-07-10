//
//  DataType.swift
//  DataTypeProject
//
//  Created by Salwa Kisswani on 7/8/19.
//  Copyright © 2019 Salwa Kisswani. All rights reserved.
//
import Foundation
import UIKit

struct DataType: Decodable {
    
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
    }}
