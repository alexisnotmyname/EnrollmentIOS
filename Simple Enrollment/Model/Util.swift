//
//  Util.swift
//  Simple Enrollment
//
//  Created by Alexander Roca on 7/6/20.
//  Copyright © 2020 Alexander Roca. All rights reserved.
//

import Foundation
import UIKit

struct Util {
    
    static func getTempFileName() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        return "TEMP_\(formatter.string(from: Date())).jpg"
    }
}

fileprivate var aView: UIView?

extension UIViewController {
    func showLoader() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
        
    }
    
    func dismissLoader() {
        aView?.removeFromSuperview()
        aView = nil
    }
}
