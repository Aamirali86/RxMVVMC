//
//  Instantiating.swift
//  UIToolKit
//

import UIKit

struct Instantiating<View: UIView> {
    
    static func instantiate() -> View {
        return create()
    }
    
    private static func nib() -> UINib {
        return UINib(nibName: nibName, bundle: bundle)
    }
    
    // MARK: - Private
    
    private static var bundle: Bundle {
        return Bundle(for: View.self)
    }
    
    private static var nibName: String {
        return String(describing: View.self)
    }
    
    private static func create() -> View {
        let bundle = self.bundle
        let nibName = self.nibName
        let nibContents = bundle.loadNibNamed(nibName, owner: nil, options: nil)
        return nibContents?.first { $0 is View } as! View
    }
}

