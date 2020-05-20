//
//  Helper.swift
//  CustomNavBarMenu
//
//  Created by Resham gurung on 18/05/2020.
//  Copyright © 2020 Resham gurung. All rights reserved.
//

import UIKit


/// UTILITY
struct Utility {
    
    /// func to get the max length of the string in a array of strings
    static func getLongestString(dataArray: [String]) -> String {
        
        if let longest = dataArray.max(by: { $0.count < $1.count }) {
            
            return longest
        }
        
        return ""
    }
    
    static func estimatedTextSize(text: String, with font: UIFont) -> CGSize {
        
        let estimateSize = text.size(withAttributes: [
            NSAttributedString.Key.font : font
        ])
        
        return estimateSize
    }
    
    
}
