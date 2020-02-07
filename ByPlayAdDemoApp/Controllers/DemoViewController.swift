//
//  DemoViewController.swift
//  ByPlayAdDemoApp
//
//  Created by 野田直軌 on 2020/02/05.
//  Copyright © 2020 Tsumiki Inc. All rights reserved.
//

import UIKit
import ByPlayAd

class DemoViewController: UIViewController {
  
  @IBOutlet weak var videoAdView: TIBVideoAdView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // This Setting is debug only
    TIBAdSettings.setTest(true)
    TIBAdSettings.setTest(true)
    
    videoAdView.isHidden = true
    videoAdView.delegate = self
    videoAdView.laodAd(with: 1234)
  }
}

extension DemoViewController: TIBVideoAdViewDelegate {
  
  func videoAdViewDidLoaded(_ view: TIBVideoAdView, isFirstLoaded: Bool, atIndex: Int) {
    print("video did loaded, isFirstLoaded: \(isFirstLoaded), atIndex: \(atIndex)")
    
    if isFirstLoaded {
      videoAdView.isHidden = false
    }
  }
  
  func videoAdView(_ view: TIBVideoAdView, didFailedWith error: TIBAdError) {
    print("video did failed \(error)")
    switch error {
    case .none:
      print("errror none")
    case .networkError:
      print("net work error")
    case .noFill:
      print("no Fill")
    case .wrongSectionId:
      print("wrong section Id")
    case .playerError:
      print("player error")
    }
  }
  
  func videoAdViewDidClose(_ view: TIBVideoAdView, atIndex: Int) {
    print("video did close atIndex: \(atIndex)")
    videoAdView.isHidden = true
  }
  
  func videoAdViewDidEnd(_ view: TIBVideoAdView, atIndex: Int) {
    print("video did end atIndex: \(atIndex)")
  }
  
  func videoAdViewDidStart(_ view: TIBVideoAdView, atIndex: Int) {
    print("video did start atIndex: \(atIndex)")
  }
  
  func videoAdViewDidReplay(_ view: TIBVideoAdView, atIndex: Int) {
    print("video did replay atIndex: \(atIndex)")
  }
  
  func videoAdViewDidResume(_ view: TIBVideoAdView, atIndex: Int) {
    print("video did resume atIndex: \(atIndex)")
  }
      
  func videoAdViewShouldClickViewEvent(_ view: TIBVideoAdView,
                                       url: URL,
                                       atIndex: Int) -> Bool {
    print("click view url: \(url) atIndex: \(atIndex)")
    return true
  }
}
