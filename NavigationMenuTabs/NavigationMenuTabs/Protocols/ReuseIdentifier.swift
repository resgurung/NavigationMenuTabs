//
//  ReuseIdentifier.swift
//  CustomNavBarMenu
//
//  Created by Resham gurung on 18/05/2020.
//  Copyright © 2020 Resham gurung. All rights reserved.
//

import Foundation


protocol ReuseIdentifier {
     /// cell identifier
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifier {
    
    static var reuseIdentifier: String {
        
        return String(describing: Self.self)
    }
}
