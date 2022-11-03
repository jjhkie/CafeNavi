//
//  ModalViewController.swift
//  CafeNavi
//
//  Created by 김진혁 on 2022/11/01.
//

import UIKit

class ModalViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
           view.isOpaque = false

           self.preferredContentSize = CGSize(width: 100, height: 100)
       // self.view.backgroundColor = .blue
        
//        self.modalPresentationStyle = .currentContext
//
//        if let sheet = self.sheetPresentationController {
//
//            //지원할 크기 지정
//            sheet.detents = [.medium(), .large() ]
//            //크기 변하는거 감지
//            //sheet.delegate = self
//            sheet.largestUndimmedDetentIdentifier = .large
//            //시트 상단에 그래버 표시 (기본 값은 false)
//            sheet.prefersGrabberVisible = true
//
//            //처음 크기 지정 (기본 값은 가장 작은 크기)
//            sheet.selectedDetentIdentifier = .medium
//
//            //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
//            //sheet.largestUndimmedDetentIdentifier = .medium
//        }
    }
}
