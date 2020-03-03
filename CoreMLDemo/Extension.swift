//
//  Extension.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 30.10.2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        clipsToBounds = true
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 2
        layer.shadowRadius = 10    }
}
