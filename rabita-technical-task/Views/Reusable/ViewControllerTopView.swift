//
//  ViewControllerTopView.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import UIKit.UIView
import Combine

final class ViewControllerTopView: UIView {
  
  let dismiss = PassthroughSubject<Void, Never>()
  let segmentChanged = PassthroughSubject<Int, Never>()
  
  private let segmentController: UISegmentedControl = {
      let segment = UISegmentedControl()
      segment.backgroundColor = .lightGray.withAlphaComponent(0.3)
      return segment
  }()
  
  private let dismissButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(systemName: "xmark"), for: .normal)
      button.tintColor = .black
      button.layer.masksToBounds = false
      button.layer.cornerRadius = 8
      return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
    setupActions()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let width = bounds.width / 2
    segmentController.widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    backgroundColor = .lightGray.withAlphaComponent(0.1)
    
    appendSubview(segmentController)
    segmentController.heightAnchor.constraint(equalToConstant: 30).isActive = true
    segmentController.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    segmentController.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

    
    appendSubview(dismissButton)
    dismissButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    
    
  }
  
  func insertSegments(segments: [Segmentable]) {
    for (index, segment) in segments.enumerated() {
      segmentController.insertSegment(withTitle: segment.title,
                                      at: index,
                                      animated: true)
    }
    segmentController.selectedSegmentIndex = 0
  }
  
  private func setupActions() {
    segmentController.addAction(
      UIAction { [weak self] _ in
      
        guard let self = self else { return }
        self.segmentValueChanged(self.segmentController)
        
      }, for: .valueChanged)
    
    dismissButton.addAction(
      UIAction{ [weak self] _ in
      
        self?.dismiss.send()
        
    }, for: .touchUpInside)
  }
  
  @objc private func segmentValueChanged(_ sender: UISegmentedControl) {
    segmentChanged.send(sender.selectedSegmentIndex)
  }
  
  func getSegmentView() -> UISegmentedControl {
    return segmentController
  }
}
