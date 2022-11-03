//
//  MainViewController.swift
//  CafeNavi
//
//  Created by 김진혁 on 2022/11/01.
//

import UIKit
import NMapsMap
import CoreLocation

final class MainViewController: UIViewController{
    
    var locationManager = CLLocationManager()
    lazy var mapOb: NMFNaverMapView = NMFNaverMapView(frame: view.frame)
    var geo: CLGeocoder = CLGeocoder()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setModal()
        map()
        bind(MainViewModel())
        attribute()
        layout()
    }
    
    private func setModal(){
        let detailViewController = ModalViewController()
           let nav = UINavigationController(rootViewController: detailViewController)
           // 1
           nav.modalPresentationStyle = .pageSheet

           // 2
           if let sheet = nav.sheetPresentationController {

               //medium 사이즈일 때 main View Opacity 제거
               sheet.prefersGrabberVisible = true
               sheet.largestUndimmedDetentIdentifier = .medium
               sheet.prefersEdgeAttachedInCompactHeight = true
               // 3
               sheet.detents = [.medium(), .large()]

           }
           // 4
           present(nav, animated: true, completion: nil)
    }
//    private func setModal(){
//        self.definesPresentationContext = true
//        let modalViewController = ModalViewController()
//           modalViewController.definesPresentationContext = true
//        modalViewController.modalPresentationStyle = .currentContext
//           navigationController?.present(modalViewController, animated: true, completion: nil)
//    }

}


//UI 설정 및 autolayout 설정
extension MainViewController{
    
    private func bind(_ VM: MainViewModel){
        
    }
    
    private func attribute(){

        mapOb.showLocationButton = true
        mapOb.showZoomControls = true
        
    }
    
    private func layout(){
        [mapOb].forEach{
            view.addSubview($0)
        }
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

