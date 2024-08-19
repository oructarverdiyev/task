//
//  Array+extension.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 19.08.24.
//

import Foundation

extension Array {
    subscript(optional index: Index) -> Iterator.Element? {
        return self.indices.contains(index) ? self[index] : nil
    }
}
