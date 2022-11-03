//
//  MainModel.swift
//  CafeNavi
//
//  Created by 김진혁 on 2022/11/03.
//

import Foundation

struct MainModel{
    var localNetwork: LocalNetwork
    
    init(localNetwork: LocalNetwork = LocalNetwork()) {
        self.localNetwork = localNetwork
    }
    
}
