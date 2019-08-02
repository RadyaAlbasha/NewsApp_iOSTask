//
//  UIMethodsClass.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/1/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import UIKit
class UIMethodsClass {
    static func roundedView (rView : AnyObject , radius : CGFloat){
        rView.layer.cornerRadius = radius
        rView.layer.masksToBounds = true
    }
}
