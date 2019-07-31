//
//  Carousel.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import Foundation

typealias CarouselItems = [CarouselItem]

struct CarouselItem: Codable {
    let preview, title, subtitle: String
}

