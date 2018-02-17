//
//  ViewController.swift
//  Snapchat Menu & Camera
//
//  Created by qinge on 2018/2/17.
//  Copyright © 2018年 qin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = true
        
        let leftVC = LeftViewController(nibName: "LeftViewController", bundle: nil)
        let centerVC = CenterViewController(nibName: "CenterViewController", bundle: nil)
        let rightVC = RightViewController(nibName: "RightViewController", bundle: nil)
        
        addChildViewController(leftVC)
        self.scrollView.addSubview(leftVC.view)
        leftVC.didMove(toParentViewController: self)
        
        addChildViewController(centerVC)
        self.scrollView.addSubview(centerVC.view)
        centerVC.didMove(toParentViewController: self)
        
        
        addChildViewController(rightVC)
        self.scrollView.addSubview(rightVC.view)
        rightVC.didMove(toParentViewController: self)
        
        var centerViewFrame: CGRect = centerVC.view.frame
        centerViewFrame.origin.x = self.view.frame.width
        centerVC.view.frame = centerViewFrame
        
        var rightViewFrame: CGRect = rightVC.view.frame
        rightViewFrame.origin.x = 2 * self.view.frame.width
        rightVC.view.frame = rightViewFrame
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.size.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

