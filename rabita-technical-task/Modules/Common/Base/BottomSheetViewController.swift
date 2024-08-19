//
//  BottomSheetViewController.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 19.08.24.
//

import UIKit.UIViewController
import FloatingPanel

final class BottomSheetViewController: FloatingPanelController {
  private let panelState: BottomSheetState
  
  enum BottomSheetState {
    case half(CGFloat)
    case halfWithGrabber(CGFloat)
    case full(CGFloat)
    case fullWithGrabber(CGFloat)
  }
  
  init(with state: BottomSheetState = .fullWithGrabber(0.4)) {
    self.panelState = state
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

extension BottomSheetViewController {
  private func setupView() {
    isRemovalInteractionEnabled = true
    
    let appearance = SurfaceAppearance()
    appearance.cornerRadius = 15
    
    surfaceView.appearance = appearance
    delegate = self
  }
}

extension BottomSheetViewController: FloatingPanelControllerDelegate {
  func floatingPanel(_ fpc: FloatingPanelController,
                     layoutFor newCollection: UITraitCollection
  ) -> FloatingPanelLayout {
    switch panelState {
    case .half(let inset):
      surfaceView.grabberHandle.isHidden = true
      backdropView.dismissalTapGestureRecognizer.isEnabled = false
      return CompleteLayout(with: inset)
    case .halfWithGrabber(let inset):
      backdropView.dismissalTapGestureRecognizer.isEnabled = false
      return CompleteLayout(with: inset)
    default:
      surfaceView.grabberHandle.isHidden = false
      backdropView.dismissalTapGestureRecognizer.isEnabled = true
      return BottomSheetLayout()
    }
  }
  
  func floatingPanelShouldBeginDragging(_ fpc: FloatingPanelController
  ) -> Bool {
    switch panelState {
    case .half:
      return false
    default:
      return true
    }
  }
  
  func dismissalEnabled(with enabled: Bool) {
    self.backdropView.dismissalTapGestureRecognizer.isEnabled = enabled
  }
}
