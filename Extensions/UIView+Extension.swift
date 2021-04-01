//
//  UIView+Extension.swift
//  TableView
//
//  Created by Deeksha Kaul on 01/04/21.
//  Copyright © 2021 Deeksha Kaul. All rights reserved.
//

import Foundation
import UIKit

public struct LayoutConstants {
    public static let padding1x: CGFloat = 10
    public static let padding1nHalfx: CGFloat = 15
}

public struct FontSize {
    public static let body: CGFloat = 14
    public static let header: CGFloat = 16
}

public struct FontFamily {
    public static let standard = "TimesNewRomanPSMT"
    public static let bold = "TimesNewRomanPS-BoldMT"
    
}

extension UIView {
    
    func setConstraintsToEdge(with view: UIView,
                              left: CGFloat? = .zero,
                              right: CGFloat? = .zero,
                              top: CGFloat? = .zero,
                              botton: CGFloat? = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
}
