//
//  Debouncer.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 19.08.24.
//

import Foundation

class Debouncer {
  private let queue: DispatchQueue
  private var workItem: DispatchWorkItem = DispatchWorkItem(block: {})
  private var delay: TimeInterval
  
  init(delay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
    self.delay = delay
    self.queue = queue
  }
  
  func debounce(block: @escaping () -> Void) {
    workItem.cancel()
    workItem = DispatchWorkItem { [weak self] in
      block()
      self?.workItem.cancel()
    }
    queue.asyncAfter(deadline: .now() + delay, execute: workItem)
  }
}
