//
//  DemoTableViewController.swift
//  ByPlayAdDemoApp
//
//  Created by 野田直軌 on 2020/02/05.
//  Copyright © 2020 Tsumiki Inc. All rights reserved.
//

import UIKit
import ByPlayAd

class DemoTableViewController: UITableViewController {
  private let sampleCellIdentifier = "SampleCellIdentifier"
  private let videoAdCellIdentifier = "VideoAdCellIdentifier"
  
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

extension DemoTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == Section.videoAd.rawValue {
      return videoAdView?.isHidden ?? true ? 0 : 1
    } else {
      return 15
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell
    if indexPath.section == Section.videoAd.rawValue {
      cell = tableView.dequeueReusableCell(withIdentifier: videoAdCellIdentifier)!
      if let adv = videoAdView, !adv.isHidden, adv.superview == nil {
        cell.contentView.addSubview(adv)
        adv.frame = cell.contentView.bounds
        adv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      }
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: sampleCellIdentifier)!
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == Section.videoAd.rawValue {
      return TIBVideoAdView.getViewHeight(fromWidth: view.bounds.width)
    } else {
      return 44.0
    }
  }
}

extension DemoTableViewController: TIBVideoAdViewDelegate {
  func videoAdViewDidLoaded(_ view: TIBVideoAdView, isFirstLoaded: Bool, atIndex: Int) {
    print("video did loaded, isFirstLoaded: \(isFirstLoaded), atIndex: \(atIndex)")
    if isFirstLoaded {
      videoAdView?.isHidden = false
      tableView.reloadData()
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
    tableView.reloadSections(IndexSet(integer: Section.videoAd.rawValue), with: .none)
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
