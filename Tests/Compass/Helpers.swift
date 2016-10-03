import Foundation
@testable import Compass

// MARK: - Routes

class TestRoute: Routable {

  var resolved = false

  func navigate(to location: Location, from currentController: Controller) throws {
    resolved = true
  }
}

class ThrowableRoute: Routable {

  enum InternalError: Error {
    case Unknown
  }

  func navigate(to location: Location, from currentController: Controller) throws {
    throw InternalError.Unknown
  }
}

class ErrorRoute: ErrorRoutable {

  var error: Error?

  func handle(_ routeError: Error, from currentController: Controller) {
    error = routeError
  }
}

// MARK: - Shuffle

extension Array {
  /// Return a copy of `self` with its elements shuffled
  func shuffle() -> [Element] {
    var list = Array(self)

    for i in 0..<list.count - 1 {
      let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
      guard i != j else { continue }
      (list[i], list[j]) = (list[j], list[i])
    }

    return list
  }
}

