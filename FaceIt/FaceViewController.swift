//
//  ViewController.swift
//  FaceIt
//
//  Created by Ryan Lau on 6/17/16.
//  Copyright © 2016 Ryan Lau. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    // Model
    var expression = FacialExpression( eyes: .Open, eyeBrows: .Normal, mouth: .Smile) {
        didSet {
            // will only run after initialization
            updateUI()
        }
    }
    
    // View
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))
                ))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {
            switch expression.eyes {
            case .Open : expression.eyes = .Closed
            case .Closed : expression.eyes = .Open
            case .Squinting : break
            }
        }
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    private var mouthCurvatures = [
        FacialExpression.Mouth.Frown: -1.0,
        .Grin : 0.5,
        .Smile : 1.0,
        .Smirk : -0.5,
        .Neutral : 0.0
    ]
    
    private var eyeBrowTilts = [
        FacialExpression.EyeBrows.Relaxed : 0.5,
        .Furrowed : -0.5,
        .Normal : 0.0
    ]
    
    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyesOpen = true
            case .Closed: faceView.eyesOpen = false
            case .Squinting: faceView.eyesOpen = false
            }
            faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
            faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        }
    }
}

