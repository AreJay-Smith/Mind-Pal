//
//  TrainingPageViewController.swift
//  MindPal
//
//  Created by Randall Smith on 6/25/19.
//  Copyright © 2019 Randall Smith. All rights reserved.
//

import UIKit

class TrainingPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        // Do any additional setup after loading the view.
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController("screen1"),
                self.newColoredViewController("screen2"),
                self.newColoredViewController("screen3"),
                self.newColoredViewController("screen4"),
                self.newColoredViewController("screen5"),
                self.newColoredViewController("screen6"),
                self.newColoredViewController("screen7"),
                self.newColoredViewController("screen8"),
                self.newColoredViewController("screen9"),
                self.newColoredViewController("screen10"),
                self.newColoredViewController("screen11"),
                self.newColoredViewController("screen12"),
                self.newColoredViewController("screen13"),
                self.newColoredViewController("screen14"),
                self.newColoredViewController("screen15")]
    }()
    
    private func newColoredViewController(_ color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(color)ViewController")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex + 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex - 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        guard nextIndex >= 0 else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
