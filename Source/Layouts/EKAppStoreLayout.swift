//
//  EKAppStoreLayout.swift
//  EKCollectionLayout
//
//  Created by Erik Kamalov on 7/22/19.
//  Copyright © 2019 Neuron. All rights reserved.
//

import UIKit

public class EKAppStoreLayout {
    init() {
        
    }
}


extension EKAppStoreLayout: LayoutAttributesConfigurator {
    
    public func prepare(layout flow: EKLayoutFlow) {
         assert(flow.collectionView.numberOfSections == 1, "Multi section aren't supported!")
         assert(flow.scrollDirection == .horizontal, "Horizontal scroll direction aren't supported!")
        
        if flow.collectionView.decelerationRate != .fast  { flow.collectionView.decelerationRate = .fast }

    }
    
}

