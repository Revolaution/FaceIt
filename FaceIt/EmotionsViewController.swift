//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Ryan Lau on 6/20/16.
//  Copyright © 2016 Ryan Lau. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
        "angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievous" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
    ]
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationViewController = segue.destinationViewController
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        if let faceViewController = destinationViewController as? FaceViewController {
            if let identifier = segue.identifier {
                if let expression = emotionalFaces[identifier] {
                    faceViewController.expression = expression
                }
                if let sendingButton = sender as? UIButton {
                    faceViewController.navigationItem.title = sendingButton.currentTitle
                }
                
            }
        }
        
    }

}
