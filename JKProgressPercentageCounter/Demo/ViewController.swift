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
        
        self.title = "Progress Indicator Demo"
        let progressIndicatorView1 = self.progressIndicatorViewWithCurrentValue(75, maximumValue: 100, titleDirection: .Top, shape: .Circle, bgColor: UIColor.redColor())
        let progressIndicatorView2 = self.progressIndicatorViewWithCurrentValue(175, maximumValue: 200, titleDirection: .Left, shape: .Flat, bgColor: UIColor.blueColor())
        let progressIndicatorView3 = self.progressIndicatorViewWithCurrentValue(1175, maximumValue: 1500, titleDirection: .Bottom, shape: .Circle, bgColor: UIColor.orangeColor())
        let progressIndicatorView4 = self.progressIndicatorViewWithCurrentValue(10, maximumValue: 80, titleDirection: .Right, shape: .Circle, bgColor: UIColor.yellowColor())
        
        let viewsCollection = [progressIndicatorView1, progressIndicatorView2, progressIndicatorView3, progressIndicatorView4]
        var previousView: UIView? = nil
        let topLayoutGuide = self.topLayoutGuide
        let metrics = ["viewHeight": 64]
        
        for individualView in viewsCollection {
            if previousView == nil {
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[topLayoutGuide]-[individualView(viewHeight)]", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: ["individualView": individualView, "topLayoutGuide": topLayoutGuide]))
            } else {
                self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[previousView]-[individualView(viewHeight)]", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: ["previousView": previousView!, "individualView": individualView]))
            }
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[individualView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["individualView": individualView]))
            previousView = individualView
        }
        
        for (index, individualView) in viewsCollection.enumerate() {
            individualView.showLegendView = index % 2 == 0
            individualView.showLabelWithDuration(NSTimeInterval(index + 1), labelFormatterClosure: {[weak individualView] labelValueInt, labelValueString in
                individualView!.updatedLabelValue = "\(labelValueString)%"
                }, completionClosure: {
                    print("Completed Animation")
            })
        }
    }
    
    func progressIndicatorViewWithCurrentValue(currentValue: Int, maximumValue: Int, titleDirection: TitleDirection, shape: ProgressIndicatorShape, bgColor: UIColor) -> JKProgressPercentageCounterView {
        let progressIndicatorView = JKProgressPercentageCounterView(frame: CGRectZero, currentValue: currentValue, maximumValue: maximumValue, titleDirection: titleDirection, progressIndicatorHeight: 20)
        progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        progressIndicatorView.progressIndicatorShape = shape
        progressIndicatorView.updatedLabelValue = "\(progressIndicatorView.originalLabelValue)%"
        progressIndicatorView.progressIndicatorBackgroundColor = bgColor
        progressIndicatorView.layer.borderColor = UIColor.blackColor().CGColor
        progressIndicatorView.layer.borderWidth = 1.0
        self.view.addSubview(progressIndicatorView)
        return progressIndicatorView
    }

}

