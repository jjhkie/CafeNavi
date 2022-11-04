//
//  LocalAPI.swift
//  CafeNavi
//
//  Created by 김진혁 on 2022/11/03.
//

import Foundation
import NMapsMap

//kakao 카테고리로 장소 검색하기
struct LocalApi{
    static let scheme = "https"
    static let host = "dapi.kakao.com"
    static let path = "/v2/local/search/category.json"
    
    func getLocation(by mapPoint: NMGLatLng) -> URLComponents{
        var components = URLComponents()
        components.scheme = LocalApi.scheme
        components.host = LocalApi.host
        components.path = LocalApi.path
        
        components.queryItems = [
            URLQueryItem(name: "category_group_code", value: "CE7"),
            URLQueryItem(name: "x", value: "\(mapPoint.lng)"),
            URLQueryItem(name: "y", value: "\(mapPoint.lat)"),
            URLQueryItem(name: "radius", value: "500"),
            URLQueryItem(name: "sort", value: "distance")
        ]
        
        return components
    }
}
