//
//  Genres.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import Foundation

typealias Genres = [Genre]

struct Genre: Codable {
    let preview, name: String
    let items: [Item]
}

struct Item: Codable {
    let preview: String
}
