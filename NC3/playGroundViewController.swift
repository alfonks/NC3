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
        
        let hold = UILongPressGestureRecognizer(target: self, action: #selector(longAction(_:)))
        robot.addGestureRecognizer(hold)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    
    private func loadBehavior() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionMode = .everything
        
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collisionBehavior)
        dynamicAnimator.addBehavior(pushBehavior)
    }
    
    @objc func longAction(_ selector: UILongPressGestureRecognizer) {
        if selector.state == .began {
            imageInsideView.image = #imageLiteral(resourceName: "rsz_hold_1")
            
        } else if selector.state == .ended {
            self.reset()
        }
    }
    
    @objc func swipeAction(_ selector: UISwipeGestureRecognizer) {
        if selector.direction == .left {
            let coordinate = CGPoint(x: view.center.x - 145, y: view.center.y)
            robot.center = coordinate
            self.imageInsideView.image = #imageLiteral(resourceName: "rsz_left_1")
        }
        
        if selector.direction == .right {
            let coordinate = CGPoint(x: view.center.x + 175, y: view.center.y)
            robot.center = coordinate
            self.imageInsideView.image = #imageLiteral(resourceName: "rsz_right_1")
        }
        
        DispatchQueue.main.asyncAfter (deadline: .now() + 2.0){
            self.reset()
        }
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
        let animator = UIViewPropertyAnimator(
        duration: 1,
        dampingRatio: 1) {
            self.imageInsideView.image = #imageLiteral(resourceName: "rsz_still_1")
            self.dynamicAnimator.updateItem(usingCurrentState: self.robot)
        }
        animator.startAnimation()

        
        
        
    }


}
