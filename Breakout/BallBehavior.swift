//
//  BouncerBehavior.swift
//  Bouncer
//
//  Created by Géza Mikló on 08/04/15.
//  Copyright (c) 2015 Géza Mikló. All rights reserved.
//

import UIKit

class BallBehavior: UIDynamicBehavior, UICollisionBehaviorDelegate {
    let gravity = UIGravityBehavior()
    
    lazy var collider : UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        lazilyCreatedCollider.collisionMode = UICollisionBehaviorMode.Everything
        lazilyCreatedCollider.collisionDelegate = self
        return lazilyCreatedCollider
        }()
    
    lazy var ballBehavior: UIDynamicItemBehavior = {
        let lazilyCreatedBallBehavior = UIDynamicItemBehavior()
        lazilyCreatedBallBehavior.allowsRotation = true
        lazilyCreatedBallBehavior.elasticity = 1.0
        lazilyCreatedBallBehavior.friction = 0
        lazilyCreatedBallBehavior.resistance = 0
        
        return lazilyCreatedBallBehavior
        }()
    
    lazy var pushBehavior : UIPushBehavior = {
        let lazyPushBehavior = UIPushBehavior(items: [], mode: UIPushBehaviorMode.Instantaneous)
        lazyPushBehavior.pushDirection = CGVectorMake(0.1, 0.5)
        lazyPushBehavior.active = true
        return lazyPushBehavior
    }()
    
    func addBarrier(path: UIBezierPath, name: String) {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    
    func removeBarrier(name: String) {
        collider.removeBoundaryWithIdentifier(name)
    }
    
    override init() {
        super.init()
        
        //addChildBehavior(gravity)
        addChildBehavior(pushBehavior)
        addChildBehavior(collider)
        addChildBehavior(ballBehavior)
    }
    
    func addBall(ball: UIView) {
        dynamicAnimator?.referenceView?.addSubview(ball)

        //gravity.addItem(ball)
        ballBehavior.addItem(ball)
        pushBehavior.addItem(ball)
        collider.addItem(ball)
    }
    
    func removeBall(ball: UIView) {
        gravity.removeItem(ball)
        collider.removeItem(ball)
        ballBehavior.removeItem(ball)
        pushBehavior.removeItem(ball)
        
        
        ball.removeFromSuperview()
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        println("Collide began")
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem) {
        println("Collide ended")
    }

}
