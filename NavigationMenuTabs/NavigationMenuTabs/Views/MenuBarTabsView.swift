//
//  MenuBarView.swift
//  CustomNavBarMenu
//
//  Created by Resham gurung on 18/05/2020.
//  Copyright © 2020 Resham gurung. All rights reserved.
//

import UIKit

/*
 
    Nav Menu tab bar
    ------------------------------------------------
   |                                                |
   | <                 Nav Bar                  +   |
   |                                                |
    -----------------------------------------------------------------------------
   |              |                |                |               |            |
   |    Menu 1    |    Menu 2      |     Menu 3     |     Menu 4    |   Menu 5   |
   |______________|________________|________________|_______________|____________|
    ------------------------------------------------------------------------------
*/


protocol MenuBarTabsViewDelegate: class {
    
    func didSelectItem(at index:Int)
}


class MenuBarTabsView: UIView {
    
    /// menu bar item clicked handler delegate
    weak var delegate: MenuBarTabsViewDelegate?
    
    /// menu bar  as collectionview
    lazy var menuCollectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        
        /// direction horizontal
        layout.scrollDirection = .horizontal
        
        /// space on top and bottom
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        /// hide scroll bar
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = .systemGroupedBackground
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    /// menu data holder
    var dataSource: [ String ] = [] {
        
        didSet {
            
            self.longestMenuString = Utility.getLongestString(dataArray: dataSource)
            
            self.menuCollectionView.reloadData()
        }
    }
    
    /// flag if the cell width should be drawn equal. Note: the width will be the longest text width in the dataArray.
    /// if false the cell width will be the text width in the data array
    var cellSizeToFitText: Bool = true {
        
        didSet {
            
            self.menuCollectionView.reloadData()
        }
    }
    
    var longestMenuString: String = ""
    
    /// inisilize
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    /// required
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    /// set up view
    private func setupView() {
        
        backgroundColor = .clear
        
        menuCollectionView.register(BasicCollectionViewCell.self,
                                    forCellWithReuseIdentifier: BasicCollectionViewCell.reuseIdentifier)
        
        addSubview(menuCollectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
            menuCollectionView.topAnchor.constraint(equalTo: topAnchor),
            
            menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}


    // MARK: - UICollectionViewDataSource
extension MenuBarTabsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
     
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let basicCell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.reuseIdentifier,
                                                           for: indexPath) as! BasicCollectionViewCell
        
        basicCell.textLabel.text = dataSource[indexPath.item]
        
        return basicCell
    }
    
    
}

    // MARK: - UICollectionViewDelegate
extension MenuBarTabsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectItem(at: indexPath.item)
    }
}

extension MenuBarTabsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = dataSource[indexPath.item]
        
        let padding: CGFloat = 15
        
        let height = self.frame.height

        if cellSizeToFitText {

            let size = Utility.estimatedTextSize(text: text, with: UIFont.preferredFont(forTextStyle: .headline))
        
            return CGSize(width: size.width + padding, height: height)
            
        } else {
            
            let size = Utility.estimatedTextSize(text: longestMenuString, with: UIFont.preferredFont(forTextStyle: .headline))
            // return same size for all the cell depending on the longest text length
            return CGSize(width: size.width + padding, height: height)
        }
    }
}
