//
//  ViewController.swift
//  JKProgressPercentageCounter
//
//  Created by Jayesh Kawli Backup on 6/11/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let progressIndicatorView = JKProgressPercentageCounterView(frame: CGRectZero, currentValue: 75, maximumValue: 100, titleDirection: .Top, progressIndicatorHeight: 20)
        progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        progressIndicatorView.progressIndicatorShape = ProgressIndicatorShape.Circle
        progressIndicatorView.updatedLabelValue = "\(progressIndicatorView.originalLabelValue)%"
        progressIndicatorView.progressIndicatorBackgroundColor = UIColor.greenColor()
        
        self.view.addSubview(progressIndicatorView)
        let views = ["progressIndicatorView": progressIndicatorView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[progressIndicatorView(84)]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[progressIndicatorView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        
        progressIndicatorView.showLabelWithDurtion(1.0, labelFormatterClosure: { labelValue in
            progressIndicatorView.updatedLabelValue = "\(labelValue)%"
        })
        
    }

}

