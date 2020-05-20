//
//  BasicCollectionViewCell.swift
//  CustomNavBarMenu
//
//  Created by Resham gurung on 18/05/2020.
//  Copyright © 2020 Resham gurung. All rights reserved.
//


import UIKit

/// Basic collectionview cell with label
class BasicCollectionViewCell: UICollectionViewCell {
    
    /// menu text label
    var textLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .secondaryLabel
        
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        label.textAlignment = .center
        
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    /// bottom colored line indicating the selected cell
    var indicatorView: UIView = {
        
        let uiview = UIView()
        
        uiview.translatesAutoresizingMaskIntoConstraints = false
        
        return uiview
    }()
    
    /// when selected change the color to system blue
    override var isSelected: Bool {
        
        didSet {
            
            /// animate with durations
            UIView.animate(withDuration: 0.3) {
                
                /// if selected blue else clear
                self.indicatorView.backgroundColor = self.isSelected ? .systemBlue : .clear
                
                /// selected to .label
                self.textLabel.textColor = self.isSelected ? .label : .secondaryLabel

                /// redraw now
                self.layoutIfNeeded()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    /// setup label and indicator
    private func setupView() {
        
        addSubview(textLabel)
        addSubview(indicatorView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
        
        textLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 0.0).isActive = true
        
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0.0).isActive = true
        
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0.0).isActive = true
        
        indicatorView.widthAnchor.constraint(equalTo: widthAnchor, constant: 0.0).isActive = true
        
        indicatorView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
        
        indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}

extension BasicCollectionViewCell: ReuseIdentifier { }
