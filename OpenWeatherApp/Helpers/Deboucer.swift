//
//  Deboucer.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 11/2/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

final class Debouncer {

  typealias Handler = () -> Void
  var handler: Handler?

  private let timeInterval: TimeInterval
  private var timer: Timer?

  init(timeInterval: TimeInterval) {
    self.timeInterval = timeInterval
  }

  func renewInterval() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
      self?.handleTimer(timer)
    })
  }

  private func handleTimer(_ timer: Timer) {
    guard timer.isValid else {
      return
    }
    handler?()
    handler = nil
  }
}
