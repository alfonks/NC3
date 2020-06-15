//
//  playGroundViewController.swift
//  NC3
//
//  Created by Alfon on 11/06/20.
//  Copyright © 2020 Alfon. All rights reserved.
//

import UIKit

class playGroundViewController: UIViewController {

    @IBOutlet weak var robot: UIView!
    @IBOutlet weak var imageInsideView: UIImageView!
    
    let gravity = UIGravityBehavior()
    let collisionBehavior = UICollisionBehavior()
    let pushBehavior = UIPushBehavior()
    var dynamicAnimator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadGesture()
        
    }
    
    private func loadGesture() {
        
        loadBehavior()
        gravity.addItem(robot)
        collisionBehavior.addItem(robot)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        robot.addGestureRecognizer(pan)
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        robot.addGestureRecognizer(touch)
        
    }
    
    private func loadBehavior() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .everything
        
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collisionBehavior)
        dynamicAnimator.addBehavior(pushBehavior)
    }
    
    @objc func panAction(_ selector: UIPanGestureRecognizer) {
        imageInsideView.image = #imageLiteral(resourceName: "rsz_fly_1")
        view.bringSubviewToFront(robot)
        let translation = selector.translation(in: view)
//        let direction = selector.velocity(in: robot)
//        if direction.x > 0 {
//
//        } else if direction.x < 0 {
//
//        }
        robot.center = CGPoint(x: robot.center.x + translation.x, y: robot.center.y + translation.y)
        print(robot.center.x + translation.x, robot.center.y + translation.y)
        selector.setTranslation(CGPoint.zero, in: view)
        
        
        if selector.state == .ended {
            robot.center = CGPoint(x: robot.center.x + translation.x, y: robot.center.y + translation.y)
            print(robot.center.x + translation.x, robot.center.y + translation.y)
            reset()
        }
    }
    
    @objc func tapAction(_ selector: UITapGestureRecognizer) {
        print("Hello")
    }
    
    private func reset() {
//        let animator = UIViewPropertyAnimator(
//        duration: 1,
//        dampingRatio: 1) {
//            self.gravity.removeItem(self.robot)
//            self.gravity.addItem(self.robot)
//        }
//        animator.startAnimation()
        //pushBehavior.setAngle(<#T##angle: CGFloat##CGFloat#>, magnitude: <#T##CGFloat#>)
        //print("last position: ",robot.center.x, robot.center.y)
        //print("gravity position: ",robot.center.x, robot.center.y)
        
        dynamicAnimator.updateItem(usingCurrentState: robot)
        imageInsideView.image = #imageLiteral(resourceName: "rsz_still_1")
    }


}
