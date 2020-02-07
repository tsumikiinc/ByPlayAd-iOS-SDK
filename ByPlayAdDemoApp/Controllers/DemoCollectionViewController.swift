//
//  DemoCollectionViewController.swift
//  ByPlayAdDemoApp
//
//  Created by 野田直軌 on 2020/02/05.
//  Copyright © 2020 Tsumiki Inc. All rights reserved.
//

import UIKit
import ByPlayAd

class DemoCollectionViewController: UICollectionViewController {
  private let sample1CellIdentifier = "Sample1CellIdentifier"
  private let videoAdCellIdentifier = "VideoAdCellIdentifier"
  private let sample2CellIdentifier = "Sample2CellIdentifier"
  
  enum Section: Int {
    case sample1 = 0
    case videoAd
    case sample2
  }
  
  var videoAdView: TIBVideoAdView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    TIBAdSettings.setTest(true)
    
    let vFrame: CGRect = CGRect(x: 0.0,
                                y: 0.0,
                                width: view.bounds.width,
                                height: TIBVideoAdView.getViewHeight(fromWidth: view.bounds.width))
    
    videoAdView = TIBVideoAdView(frame: vFrame)
    videoAdView?.isHidden = true
    videoAdView?.delegate = self
    videoAdView?.laodAd(with: 1234)
  }
}

extension DemoCollectionViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == Section.videoAd.rawValue {
      return videoAdView?.isHidden ?? true ? 0 : 1
    } else {
      return 9
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cell: UICollectionViewCell
    switch indexPath.section {
    case Section.sample1.rawValue:
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: sample1CellIdentifier, for: indexPath)
    case Section.videoAd.rawValue:
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoAdCellIdentifier, for: indexPath)
      if let adv = videoAdView, !adv.isHidden, adv.superview == nil {
        cell.contentView.addSubview(adv)
        adv.frame = cell.contentView.bounds
        adv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      }
    default:
      cell = collectionView.dequeueReusableCell(withReuseIdentifier: sample2CellIdentifier, for: indexPath)
    }
    return cell
  }
}

extension DemoCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == Section.videoAd.rawValue {
      let viewWidth = collectionView.bounds.width
      let viewHeight = TIBVideoAdView.getViewHeight(fromWidth: viewWidth)
      return CGSize(width: viewWidth, height: viewHeight)
    } else {
      return CGSize(width: 100, height: 100)
    }
  }
}

extension DemoCollectionViewController: TIBVideoAdViewDelegate {
  func videoAdViewDidLoaded(_ view: TIBVideoAdView, isFirstLoaded: Bool, atIndex: Int) {
    print("video did loaded, isFirstLoaded: \(isFirstLoaded), atIndex: \(atIndex)")
    if isFirstLoaded {
      videoAdView?.isHidden = false
      collectionView.reloadData()
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
    videoAdView?.removeFromSuperview()
    videoAdView = nil
    collectionView.reloadSections(IndexSet(integer: Section.videoAd.rawValue))
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
    print("click!! but don't open url")
    return false
  }
  
  
}


