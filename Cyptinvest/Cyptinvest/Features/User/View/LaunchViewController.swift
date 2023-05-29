//
//  LaunchViewController.swift
//  Cyptinvest
//
//  Created by Glenn Ludszuweit on 17/05/2023.
//

import UIKit

class LaunchViewController: UITabBarController {
    
    lazy var imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo-small")
        iv.isUserInteractionEnabled = true
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(hanleTapped))
        //        iv.addGestureRecognizer(tap)
        return iv
    }()
    
//    lazy var startButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("LFG", for: .normal)
//        button.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("loaded")
        // Do any additional setup after
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        imageView.center = CGPoint(x: self.view.frame.size.width/2, y:
                                    self.view.frame.size.height/4)
        
        animateLogo()
        
    }
    
    func animateLogo() {
        self.imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
             UIView.animate(
                withDuration: 2,
                delay: 0.0,
                usingSpringWithDamping: 0.2,
                initialSpringVelocity: 0.2,
                options: .curveEaseOut,
                animations: {
                    self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                },
                completion: nil)
    }
}
