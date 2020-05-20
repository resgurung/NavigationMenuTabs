//
//  NavigationMenuVC.swift
//  NavigationMenuTabs
//
//  Created by Resham gurung on 20/05/2020.
//  Copyright © 2020 Resham gurung. All rights reserved.
//

import UIKit

class NavigationMenuVC: UIViewController {

    private var menuBar: MenuBarTabsView = {
        
        let tabbarMenu = MenuBarTabsView()

        tabbarMenu.translatesAutoresizingMaskIntoConstraints = false
        
        return tabbarMenu
    }()
    
    var tabs = ["1. Tab 1",
                "2. Normal Tab",
                "3. Very Long Tab",
                "4. Very Very Long Tab",
                "5. Tab 5",
                "6. Very Very Very Very Long Taaaab"]
    

    var colors: [UIColor] = [UIColor.gray,
                             UIColor.blue,
                             UIColor.orange,
                             UIColor.brown,
                             UIColor.cyan,
                             UIColor.green]
    
    private var pageVC: NavMenuPageControllerVC!
    
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMenuBar()
        
        setupPageViewController()
        
        setupInitial()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        menuBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        
        menuBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        menuBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        pageVC.view.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        pageVC.view.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        
        pageVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupMenuBar() {
        
        menuBar.delegate = self
        
        menuBar.dataSource = tabs
        
        //menuBar.cellSizeToFitText = false
        
        view.addSubview(menuBar)
    }
    
    private func setupPageViewController() {
        
        pageVC = NavMenuPageControllerVC(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageVC.view.backgroundColor = .purple
        
        pageVC.delegate = self
        
        pageVC.dataSource = self
        
        addChild(pageVC)
        
        view.addSubview(pageVC.view)
        
        pageVC.didMove(toParent: self)
    }
    
    private func setupInitial() {
        
        menuBar.menuCollectionView.selectItem(at: IndexPath(item: currentIndex, section: 0),
                                              animated: true,
                                              scrollPosition: .centeredVertically)
        
        guard let vc = presentViewcontroller(at: currentIndex) else {
            
            return
        }
        pageVC.setViewControllers([vc],
                                  direction: .forward,
                                  animated: true)
    }
    

    //Present ViewController At The Given Index
    func presentViewcontroller(at index: Int) -> UIViewController? {
        
        let count = menuBar.dataSource.count
        
        if count == 0 || index >= count {
            return nil
        }
        
        let contentVC = NavMenuContentVC()
        
        contentVC.pageIndex = index
        
        currentIndex = index
        
        contentVC.view.backgroundColor = colors[index]
        
        return contentVC
        
    }
}

extension NavigationMenuVC: MenuBarTabsViewDelegate {
    
    func didSelectItem(at index: Int) {
        
        if index != currentIndex {

            guard let contentVC = presentViewcontroller(at: index) else {
                
                return
            }
            
            index > currentIndex ? self.pageVC.setViewControllers([contentVC], direction: .forward, animated: true) : self.pageVC.setViewControllers([contentVC], direction: .reverse, animated: true)

            menuBar.menuCollectionView.scrollToItem(at: IndexPath(item: index, section: 0),
                                          at: .centeredHorizontally,
                                          animated: true)

        }    }
  
}

extension NavigationMenuVC: UIPageViewControllerDelegate {

    /*
        To show dots on the page view inplement ->
     
        => func presentationCount(for pageViewController: UIPageViewController) -> Int

        => func presentationIndex(for pageViewController: UIPageViewController) -> Int
 
     */
}

extension NavigationMenuVC: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
         
        guard let vc = viewController as? NavMenuContentVC else {
            
            return nil
        }
        
        var lastIndex = vc.pageIndex

        if lastIndex == 0 || lastIndex == NSNotFound {
         return nil
        }

        lastIndex -= 1

        return presentViewcontroller(at: lastIndex)
     }
     
     func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
         
        guard let vc = viewController as? NavMenuContentVC else {
         
            return nil
        }

        var nextIndex = vc.pageIndex

        let count = menuBar.dataSource.count

        if nextIndex == count || nextIndex == NSNotFound {
            return nil
        }

        nextIndex += 1

        return presentViewcontroller(at: nextIndex)
         
     }
    
     func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
         
         if finished && completed {
             
            guard let contentVC = pageViewController.viewControllers?.first as? NavMenuContentVC else {
                
                return
            }
            
            let newIndex = contentVC.pageIndex
            
            menuBar.menuCollectionView.selectItem(at: IndexPath(item: newIndex, section: 0),
                                         animated: true,
                                         scrollPosition: .centeredVertically)
            
            menuBar.menuCollectionView.scrollToItem(at: IndexPath(item: newIndex, section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)
             
         }
         
     }
}
