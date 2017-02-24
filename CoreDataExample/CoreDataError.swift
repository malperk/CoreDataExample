//
//  CoreDataError.swift
//  CoreDataExample
//
//  Created by Alper KARATAŞ on 23/02/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

public enum CoreDataError: Error, CustomStringConvertible, Equatable {
    case entityNotfound(name: String)
    case fetchError(errorDesc:String)
    case saveError(errorDesc:String)

    public var description: String {
        return "CoreDataError: \(caseDescription)"
    }

    var caseDescription: String {
        switch self {
        case .entityNotfound(name: let name): return "Entity \(name) not found."
        case .fetchError(errorDesc: let errorDesc): return "FetchError \(errorDesc)"
        case .saveError(errorDesc: let errorDesc): return  "SaveError \(errorDesc)"
        }
    }
    
    public static func ==(lhs: CoreDataError, rhs: CoreDataError) -> Bool {
        switch (lhs, rhs) {
        case (let .entityNotfound(str1), let .entityNotfound(str2)):
            return str1 == str2
        case (let .fetchError(str1), let .fetchError(str2)):
            return str1 == str2
        case (let .saveError(str1), let .saveError(str2)):
            return str1 == str2
        default:
            return false
        }
    }
}
