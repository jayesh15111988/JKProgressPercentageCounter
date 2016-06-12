//
//  JKProgressPercentageCounterView.swift
//  JKProgressPercentageCounter
//
//  Created by Jayesh Kawli Backup on 6/11/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

class JKProgressPercentageCounterView: UIView {
    let titleDirection: TitleDirection
    let maximumValue: Int
    let currentValue: Int
    var progressIndicatorForegroundView: UIView
    var progressIndicatorBackgroundView: UIView
    var progressIndicatorForegroundViewWidthConstraint: NSLayoutConstraint
    let progressIndicatorHeight: CGFloat
    var percentageCounterLabel: UILabel
    var fractionValue: Float
    
    var originalLabelValue: String
    
    var updatedLabelValue: String {
        didSet {
            percentageCounterLabel.text = updatedLabelValue
        }
    }
    
    var progressIndicatorShape: ProgressIndicatorShape {
        didSet {
            var progressIndicatorViewCornerRadius: CGFloat = 0.0
            if (progressIndicatorShape == ProgressIndicatorShape.Circle) {
                progressIndicatorViewCornerRadius = progressIndicatorHeight/2.0
            } else if (progressIndicatorShape == ProgressIndicatorShape.Triangle) {
                progressIndicatorViewCornerRadius = progressIndicatorHeight * 2
            }
            progressIndicatorBackgroundView.layer.cornerRadius = progressIndicatorViewCornerRadius
            progressIndicatorForegroundView.layer.cornerRadius = progressIndicatorViewCornerRadius
        }
    }
    
    
    var labelFont: UIFont {
        didSet {
            percentageCounterLabel.font = labelFont
        }
    }
    
    var labelBackgroundColor: UIColor {
        didSet {
            percentageCounterLabel.backgroundColor = labelBackgroundColor
        }
    }
    
    var labelTextColor: UIColor {
        didSet {
            percentageCounterLabel.textColor = labelTextColor
        }
    }
    
    var progressIndicatorBackgroundColor: UIColor {
        didSet {
            progressIndicatorForegroundView.backgroundColor = progressIndicatorBackgroundColor
        }
    }
    
    var progressIndicatorBorderColor: UIColor {
        didSet {
            progressIndicatorBackgroundView.backgroundColor = progressIndicatorBorderColor
        }
    }
    
    var progressIndicatorBorderWidth: CGFloat {
        didSet {
            progressIndicatorBackgroundView.layer.borderWidth = progressIndicatorBorderWidth
        }
    }
    
    init(frame: CGRect, currentValue: Int, maximumValue: Int, titleDirection: TitleDirection, progressIndicatorHeight: CGFloat) {
        
        fractionValue = Float(currentValue)/Float(maximumValue)
        let fractionInPercentage = String(format: "%d", Int(fractionValue * 100.0))
        
        self.titleDirection = titleDirection
        self.currentValue = currentValue
        self.maximumValue = maximumValue
        self.progressIndicatorShape = ProgressIndicatorShape.Circle
        self.progressIndicatorHeight = progressIndicatorHeight
        self.progressIndicatorBorderColor = UIColor.lightGrayColor()
        self.progressIndicatorBorderWidth = 0.5
        self.originalLabelValue = fractionInPercentage
        self.updatedLabelValue = fractionInPercentage
        
        percentageCounterLabel = UILabel()
        percentageCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageCounterLabel.textAlignment = NSTextAlignment.Center
        percentageCounterLabel.numberOfLines = 0
        percentageCounterLabel.text = self.originalLabelValue
        
        labelFont = UIFont.systemFontOfSize(14)
        labelBackgroundColor = UIColor .whiteColor()
        labelTextColor = UIColor.blackColor()
        progressIndicatorBackgroundColor = UIColor.redColor()
        
        progressIndicatorBackgroundView = UIView()
        progressIndicatorBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        progressIndicatorBackgroundView.backgroundColor = UIColor.whiteColor()
        progressIndicatorBackgroundView.clipsToBounds = true
        progressIndicatorBackgroundView.layer.borderWidth = progressIndicatorBorderWidth
        progressIndicatorBackgroundView.layer.borderColor = progressIndicatorBorderColor.CGColor
        
        progressIndicatorForegroundView = UIView()
        progressIndicatorForegroundView.translatesAutoresizingMaskIntoConstraints = false
        progressIndicatorForegroundView.backgroundColor = progressIndicatorBackgroundColor
        progressIndicatorForegroundView.clipsToBounds = true
        
        progressIndicatorBackgroundView.layer.cornerRadius = progressIndicatorHeight/2.0
        progressIndicatorForegroundView.layer.cornerRadius = progressIndicatorHeight/2.0
        
        self.progressIndicatorForegroundViewWidthConstraint = NSLayoutConstraint(item: progressIndicatorForegroundView, attribute: .Width, relatedBy: .Equal, toItem: progressIndicatorBackgroundView, attribute: .Width, multiplier: CGFloat(fractionValue), constant: 1.0)
        
        super.init(frame: frame)
        
        self.addSubview(progressIndicatorBackgroundView)
        self.addSubview(progressIndicatorForegroundView)
        self.addSubview(percentageCounterLabel)
        
        let views = ["progressIndicatorBackgroundView": progressIndicatorBackgroundView, "progressIndicatorForegroundView": progressIndicatorForegroundView, "percentageCounterLabel": percentageCounterLabel]
        let metrics = ["progressIndicatorHeight": progressIndicatorHeight]
        
        if (titleDirection == TitleDirection.Top) {
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[percentageCounterLabel(>=0)]-(>=5)-[progressIndicatorBackgroundView(progressIndicatorHeight)]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[percentageCounterLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[progressIndicatorBackgroundView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            
        } else if (titleDirection == TitleDirection.Left) {
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[percentageCounterLabel(>=0)]-[progressIndicatorBackgroundView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[percentageCounterLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            self.addConstraint(NSLayoutConstraint(item: progressIndicatorBackgroundView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: progressIndicatorBackgroundView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: progressIndicatorHeight))
            
        } else if (titleDirection == TitleDirection.Bottom) {
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[progressIndicatorBackgroundView(progressIndicatorHeight)]-(>=5)-[percentageCounterLabel(>=0)]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[percentageCounterLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[progressIndicatorBackgroundView]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            
        } else if (titleDirection == TitleDirection.Right) {
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[progressIndicatorBackgroundView]-[percentageCounterLabel(>=0)]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[percentageCounterLabel]-|", options: NSLayoutFormatOptions(rawValue:0), metrics: metrics, views: views))
            self.addConstraint(NSLayoutConstraint(item: progressIndicatorBackgroundView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: progressIndicatorBackgroundView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: progressIndicatorHeight))
            
        }
        
        self.addConstraint(NSLayoutConstraint(item: progressIndicatorForegroundView, attribute: .Leading, relatedBy: .Equal, toItem: progressIndicatorBackgroundView, attribute: .Leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: progressIndicatorForegroundView, attribute: .Top, relatedBy: .Equal, toItem: progressIndicatorBackgroundView, attribute: .Top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: progressIndicatorForegroundView, attribute: .Bottom, relatedBy: .Equal, toItem: progressIndicatorBackgroundView, attribute: .Bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(progressIndicatorForegroundViewWidthConstraint)
        
//        let v = UIView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = UIColor.blueColor()
//        self.addSubview(v)
//        let vs = ["v": v]
//        self.addConstraint(NSLayoutConstraint(item: v, attribute: .CenterX, relatedBy: .Equal, toItem: progressIndicatorBackgroundView, attribute: .CenterX, multiplier: 1.0, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: v, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 1))
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v]|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: vs))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLabelWithDurtion(animationDuration: NSTimeInterval, labelFormatterClosure: ((String) -> ())?, completionClosure: (() -> Void)?) {
        
        self.removeConstraint(self.progressIndicatorForegroundViewWidthConstraint)
        self.layoutIfNeeded()
        
        self.progressIndicatorForegroundViewWidthConstraint = NSLayoutConstraint(item: progressIndicatorForegroundView, attribute: .Width, relatedBy: .Equal, toItem: progressIndicatorBackgroundView, attribute: .Width, multiplier: CGFloat(fractionValue), constant: 1.0)
        self.addConstraint(self.progressIndicatorForegroundViewWidthConstraint)
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseInOut, animations: { 
            self.layoutIfNeeded()
            }, completion: nil)
        
        let delay = (animationDuration/NSTimeInterval(self.currentValue + 1)) * 1000000
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            for i in 0...self.currentValue {
                usleep(UInt32(delay))
                dispatch_async(dispatch_get_main_queue(), {
                    let labelValue = "\(String(i))"
                    self.percentageCounterLabel.text = labelValue
                    labelFormatterClosure?(labelValue)
                });
            }
            completionClosure?()
        };
        
    }
    
}
