//
//  MainViewController.swift
//  CafeNavi
//
//  Created by 김진혁 on 2022/11/01.
//

import UIKit
import NMapsMap
import CoreLocation
import SnapKit
import Alamofire

final class MainViewController: UIViewController{
    
    var cafeData: [KLDocument] = []
    
    var locationManager = CLLocationManager()
    lazy var mapOb: NMFNaverMapView = NMFNaverMapView(frame: view.frame)
    let detailList = UITableView()
    var geo: CLGeocoder = CLGeocoder()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map()
        bind(MainViewModel())
        attribute()
        layout()
    }
    
    private func getCafeData(by mapPoint: NMGLatLng){
        let api = LocalApi()
         guard let url = api.getLocation(by: mapPoint).url else{ return}
        
        print("getCafeData")
        print("호출하고 있습니다.\(url)")
       
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Authorization":"KakaoAK eb1800e4dd858d42dcd872afb475b166"])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: LocationData.self){ response in
            guard case .success(let data) = response.result else {return}
            
            self.cafeData = data.documents
            print("cafeData : \(self.cafeData)")
            self.detailList.reloadData()
        }
        
    }
}

//UI 설정 및 autolayout 설정
extension MainViewController{
    
    private func bind(_ VM: MainViewModel){
        //delegate
        mapOb.mapView.addCameraDelegate(delegate: self)
        
        
        self.detailList.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        detailList.dataSource = self
        detailList.delegate = self
        
        let input = MainViewModel.Input()
        
        let output = VM.transform(input: input)
    }
    
    private func attribute(){
        
        detailList.backgroundColor = .white
        mapOb.showLocationButton = true
        mapOb.showZoomControls = true
        
    }
    
    private func layout(){
        [mapOb,detailList].forEach{
            view.addSubview($0)
        }
        mapOb.snp.makeConstraints{
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(view.snp.centerY).offset(100)
        }
        
        detailList.snp.makeConstraints{
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(mapOb.snp.bottom)
        }
        

    }
}

extension MainViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cafeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.detailList.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.cafeData[indexPath.row].placeName
        return cell
    }
    
    
    
    
}

extension MainViewController: NMFMapViewCameraDelegate{
 
    //카메라 이동한 후 좌표
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        print("카메라 이동 후 좌표 :\(mapView.cameraPosition)")
        getCafeData(by: mapView.cameraPosition.target)
    }
}

// location 정보 받아오기
extension MainViewController: CLLocationManagerDelegate{
    
    private func map(){
        //let mapOb = NMFNaverMapView(frame: view.frame)
        
        locationManager.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    //권한이 변경되었을 때 작동하는 코드
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse,
                .authorizedAlways:
            return
        default:
//            mainVm.mapViewError.accept()
            return
        }
//        if manager.authorizationStatus == .authorizedWhenInUse{
//            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(
//                lat: manager.location?.coordinate.latitude ?? 0,
//                lng: manager.location?.coordinate.longitude ?? 0))
//            cameraUpdate.animation = .easeIn
//            mapOb.mapView.moveCamera(cameraUpdate)
//
//            //좌표를 주소로 변경하는 코드
//            geo.reverseGeocodeLocation(manager.location!) {
//                print($0)
//                print($1)
//                guard let place = $0 else {return}
//
//                print(place)
////                guard let placemarks = placemarks,
////                      let address = placemarks.last
////                else { return }
//            }
//        }else{
//            print("권한이 없습니다.")
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("위치 업데이트!")
            print("위도 : \(location.coordinate.latitude)")
            print("경도 : \(location.coordinate.longitude)")
        }
    }
        
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}

