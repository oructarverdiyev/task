//
//  BottomSheetLayout.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 19.08.24.
//

import FloatingPanel
import UIKit.UIView

final class BottomSheetLayout: FloatingPanelLayout {
  var position: FloatingPanelPosition = .bottom
  
  var initialState: FloatingPanelState = .half
  
  var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
    return [
      .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
      .half: FloatingPanelLayoutAnchor(fractionalInset: 0.4, edge: .bottom, referenceGuide: .safeArea)
    ]
  }
  
  func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
    return 0.4
  }
}
