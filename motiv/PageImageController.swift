//
//  PageImageController.swift
//  motiv
//
//  Created by Julio Espinal on 2/4/16.
//  Copyright © 2016 Julio Espinal. All rights reserved.
//


import UIKit

class PageImageController: UIPageViewController {
    
    private let imageNames: [String] = ["potential", "challenge"]
    private var uiImages: [UIImage]!
    
    private var imageControllers: [ImageController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        // gotta have my fun, too! instead of creating an array, then appending a UIImage inside a for loop,
        // use high-order functions. maps string array to uiimage array
        uiImages = imageNames.map(
            { (str: String) -> UIImage in
                return UIImage(named: str)!
            })
        
        // this one is kinda the same thing as above, but better! because what's up with that range (0...2)?!?
        // don't know how else to do it, plus i hate repeating myself. i just want to repeat the storyboard's
        // initialization function 3 times for my array of image controllers. why 3? i need current, prev, next.
        imageControllers = (0...2).map(
            { (AnyObject) -> ImageController in
                let ctrl =
                    self.storyboard!.instantiateViewControllerWithIdentifier("ImageController") as! ImageController;
                ctrl.loadView()
                return ctrl
            })
        
        self.setViewControllers([imageControllers.first!], direction: .Forward, animated: true, completion: nil)
        
        // gotta admit, this parameter naming thing gave me those good feels
        setUIImage(atIndex: 0, toControllerAtIndex: 0)
    }
    
    // i'm setting the image here now, instead of in the imagecontroller class cause it's easy
    private func setUIImage(atIndex uiIdx: Int, toControllerAtIndex cntIdx: Int) {
        
        // woot for guards! woot for this weird "is in range" operator ~=!
        guard (0..<imageControllers.count) ~= cntIdx else {
            return
        }
        
        let imgCtrlr = imageControllers[cntIdx]
        
        imgCtrlr.name             = imageNames[uiIdx]
        imgCtrlr.imageIdx         = uiIdx
        imgCtrlr.contIdx          = cntIdx;
        imgCtrlr.imageView!.image = uiImages[uiIdx]
    }
}

extension PageImageController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let cont = viewController as! ImageController
        
        guard cont.imageIdx > 0 else {
            return nil
        }
        
        // even though it's just 3 controllers, i'm gonna be generic here. nobody likes magic numbers
        let prevIdx = (cont.contIdx + imageControllers.count - 1) % imageControllers.count
        
        setUIImage(atIndex: cont.imageIdx-1, toControllerAtIndex: prevIdx)
        
        return imageControllers[prevIdx]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let cont = viewController as! ImageController
        
        guard cont.imageIdx < imageNames.count - 1 else {
            return nil
        }
        
        // even though it's just 3 controllers, i'm gonna be generic here. nobody likes magic numbers
        let nextIdx = (cont.contIdx + 1) % imageControllers.count
        
        setUIImage(atIndex: cont.imageIdx+1, toControllerAtIndex: nextIdx)
        
        return imageControllers[nextIdx]
    }
}