//
//  Coordinator.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 14.08.24.
//

protocol Coordinator: AnyObject {
  var children: [Coordinator] { get set }
  var router: Router { get }
  
  func present(animated: Bool, onDismissed: (() -> Void)?)
  func pop(animated: Bool)
  func presentChild(_ child: Coordinator, animated: Bool, onDismissed: (() -> Void)?)
  func removeChild(_ child: Coordinator)
}

extension Coordinator {
  func pop(animated: Bool) {
    router.pop(animated: true)
  }
  
  public func presentChild(_ child: Coordinator, animated: Bool, onDismissed: (() -> Void)?) {
    children.append(child)
    child.present(animated: animated, onDismissed: { [weak self, weak child] in
      guard let child = child else { return }
      self?.removeChild(child)
      onDismissed?()
    })
  }
  
  public func removeChild(_ child: Coordinator) {
    guard let index = children.firstIndex(where: { $0 === child }) else {
      return
    }
    children.remove(at: index)
  }
  
  public func clear() {
    children.removeAll()
  }
}
