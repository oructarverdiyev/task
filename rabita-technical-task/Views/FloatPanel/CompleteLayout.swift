//
//  CompleteLayout.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 19.08.24.
//

import FloatingPanel
import UIKit.UIView

final class CompleteLayout: FloatingPanelLayout {
  var position: FloatingPanelPosition = .bottom
  
  var initialState: FloatingPanelState = .half
  var fractionalInset: CGFloat
  
  init(with inset: CGFloat = 0.4) {
    self.fractionalInset = inset
  }
  
  var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
    return [
      .half: FloatingPanelLayoutAnchor(fractionalInset: fractionalInset,
                                       edge: .bottom,
                                       referenceGuide: .safeArea)
    ]
  }
  
  func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
    return 0.4
  }
}
