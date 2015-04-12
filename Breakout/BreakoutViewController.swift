//
//  ViewController.swift
//  Breakout
//
//  Created by Géza Mikló on 12/04/15.
//  Copyright (c) 2015 Géza Mikló. All rights reserved.
//

import UIKit

class BreakoutViewController: UIViewController {
    
    struct Constants {
        static let BallSize = CGSize(width: 30, height: 30)
        static let PaddleSize = CGSize(width: 100, height: 75)
        static let PaddleBarrier = "PaddleBarrier"
        static let GameArea = "GameArea"
    }
    let ballBehavior = BallBehavior()
    
    var ball : UIView?
    var paddle : UIView?
    
    lazy var animator : UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.view)
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        animator.addBehavior(ballBehavior)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        ball = addBall()
        paddle = addPaddle()
        
        let barrier = UIBezierPath(rect: self.view.bounds)
        ballBehavior.addBarrier(barrier, name: Constants.GameArea)
    }
    
    @IBAction func panned(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Changed:
            let translation = sender.translationInView(self.view)
            let newX = paddle!.center.x + translation.x
            
            if  newX > Constants.PaddleSize.width / 2 && newX < self.view.bounds.maxX - Constants.PaddleSize.width / 2 {
                paddle!.center.x = newX
                ballBehavior.addBarrier(UIBezierPath(rect: paddle!.frame), name: Constants.PaddleBarrier)
                self.animator.updateItemUsingCurrentState(paddle!)
            }
            
            sender.setTranslation(CGPointZero, inView: self.view)
        default: break
        }
    }
    
    func addBall() -> UIView {
        var ball = UIView(frame: CGRect(origin: self.view.center, size: Constants.BallSize))
        ball.backgroundColor = UIColor.blueColor()
        self.view.addSubview(ball)
        ballBehavior.addBall(ball)
        return ball
    }
    
    func addPaddle() -> UIView {
        var paddle = UIView(frame: CGRect(x: (self.view.bounds.maxX - Constants.PaddleSize.width) / 2, y: self.view.bounds.maxY - Constants.PaddleSize.height, width: Constants.PaddleSize.width, height: Constants.PaddleSize.height))
        paddle.backgroundColor = UIColor.greenColor()
        self.view.addSubview(paddle)
        
        let barrier = UIBezierPath(rect: paddle.frame)
        
        ballBehavior.addBarrier(barrier, name: Constants.PaddleBarrier)
        
        return paddle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

