//
//  Persons.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import Foundation

typealias Persons = [Person]

struct Person: Codable {
    let photo, name: String
}
