//
//  UIView+Constraints.swift
//  ShortList
//
//

import UIKit

extension UIView {
    public func pin(to superview: UIView, constant: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
    }
    
    public func pinLoose(to superview: UIView, top: CGFloat?, left: CGFloat?, right: CGFloat?, bottom: CGFloat?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
        }
        if let left = left {
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
        }
        if let right = right {
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right).isActive = true
        }
    }
}
