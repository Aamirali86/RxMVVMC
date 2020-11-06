//
//  UIView+Rx.swift
//  SwissKnife
//
//  Created by Amir on 25/10/2020.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: Tap
extension Reactive where Base: UIView {
    public var tap: ControlEvent<Void> {
        let tapGesture = UITapGestureRecognizer()
        base.addGestureRecognizer(tapGesture)
        return ControlEvent(events: tapGesture.rx.event.map { _ in })
    }
}
