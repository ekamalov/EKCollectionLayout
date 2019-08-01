//
//  HitFeed.swift
//  Example
//
//  Created by Erik Kamalov on 7/31/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import Foundation

typealias HitFeeds = [HitFeed]

struct HitFeed: Codable {
    let preview, name, channel: String
    let seasongs: Int
}
extension HitFeed {
    var title:String {
        return name
    }
    var subTitle:String {
        return self.channel + " 𐄁 \(self.seasongs) seasons"
    }
}
