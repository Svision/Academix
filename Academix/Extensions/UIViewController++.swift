//
//  UIViewController++.swift
//  Academix
//
//  Created by Changhao Song on 2021-06-25.
//

import SwiftUI

extension UIViewController {

    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
