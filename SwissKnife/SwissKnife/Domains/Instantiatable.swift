//
//  Instantiatable.swift
//  SwissKnife
//

import UIKit

public protocol Instantiatable: class {
    static func instantiate() -> Self
}
