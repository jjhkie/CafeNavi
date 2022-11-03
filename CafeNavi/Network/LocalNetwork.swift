//
//  LocalNetwork.swift
//  CafeNavi
//
//  Created by 김진혁 on 2022/11/03.
//

import RxSwift
import NMapsMap

//class LocalNetwork {
//    private let session: URLSession
//    let api = LocalApi()
//
//    init(session: URLSession = .shared) {
//        self.session = session
//    }
//
//    func getLocation(by mapPoint: NMGLatLng) -> Single<Result<LocationData, URLError>>{
//        guard let url = api.getLocation(by: mapPoint).url else{
//            return .just(.failure(URLError(.badURL)))
//        }
//
//        let request = NSMutableURLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("KakaoAK eb1800e4dd858d42dcd872afb475b166", forHTTPHeaderField: "Authorization")
//
//        return session.rx.data(request: request as URLRequest)
//            .map{data in
//                do{
//                    let locationData = try JSONDecoder().decode(LocationData.self, from: data)
//                    return .success(locationData)
//                }catch{
//                    return .failure(URLError(.cannotParseResponse))
//                }
//            }
//            .catch{ _ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
//            .asSingle()
//    }
//}
