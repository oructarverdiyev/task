//
//  UIView+extension.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 15.08.24.
//

import UIKit.UIView

extension UIView {
  static var reuseId: String {
    return "\(self)ID"
  }
  
  func addShadow(color: UIColor = .black.withAlphaComponent(0.1),
                 opacity: Float = 1,
                 offset: CGSize = CGSize(width: 0, height: 1.5),
                 radius: CGFloat = 4,
                 cornerRadius: CGFloat = 10) {
    
    self.layer.shadowColor = color.cgColor
    self.layer.shadowOpacity = opacity
    self.layer.shadowOffset = offset
    self.layer.shadowRadius = radius
    self.layer.masksToBounds = false
    self.layer.cornerRadius = cornerRadius
  }
  
  func appendSubview(_ view: UIView) {
      view.translatesAutoresizingMaskIntoConstraints = false
      addSubview(view)
  }
}
