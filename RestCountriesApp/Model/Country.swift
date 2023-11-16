//
//  Country.swift
//  RestCountriesApp
//
//  Created by Anastasiya Omak on 15/11/2023.
//

import Foundation


struct Country: Codable {
    let name: Name
//    let capital: [String?]
//    let flags: Flags
    let population: Int
}

struct Name: Codable {
    let common, official: String?
}

//struct Flags: Codable {
//    let png: String
//}

