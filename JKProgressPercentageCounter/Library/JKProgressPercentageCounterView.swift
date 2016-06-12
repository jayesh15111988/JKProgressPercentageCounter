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
    var indicatorLegend: UIView
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
            progressIndicatorBackgroundView.layer.borderColor = progressIndicatorBorderColor.CGColor
            progressIndicatorForegroundView.layer.borderColor = progressIndicatorBorderColor.CGColor
        }
    }
    
    var progressIndicatorBorderWidth: CGFloat {
        didSet {
            progressIndicatorBackgroundView.layer.borderWidth = progressIndicatorBorderWidth
            progressIndicatorForegroundView.layer.borderWidth = progressIndicatorBorderWidth
        }
    }
    
    var legendBackgroundColor: UIColor {
        didSet {
            indicatorLegend.backgroundColor = legendBackgroundColor
        }
    }
    
    var showLegendView: Bool {
        didSet {
            indicatorLegend.hidden = !showLegendView
        }
    }
    
    init(frame: CGRect, currentValue: Int, maximumValue: Int, titleDirection: TitleDirection, progressIndicatorHeight: CGFloat) {
        
        fractionValue = Float(currentValue)/Float(maximumValue)
        let fractionInPercentage = String(format: "%d", Int(fractionValue * 100.0))
        let legendDimension = progressIndicatorHeight/4.0
        
        self.titleDirection = titleDirection
        self.currentValue = currentValue
        self.maximumValue = maximumValue
        self.progressIndicatorShape = ProgressIndicatorShape.Circle
        self.progressIndicatorHeight = progressIndicatorHeight
        self.progressIndicatorBorderColor = UIColor.lightGrayColor()
        self.progressIndicatorBorderWidth = 0.5
        self.originalLabelValue = fractionInPercentage
        self.updatedLabelValue = fractionInPercentage
        self.legendBackgroundColor = UIColor.purpleColor()
        self.showLegendView = false
        
        percentageCounterLabel = UILabel()
        percentageCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        percentageCounterLabel.textAlignment = NSTextAlignment.Center
        percentageCounterLabel.numberOfLines = 0
        percentageCounterLabel.text = self.originalLabelValue
        
        labelFont = UIFont.systemFontOfSize(14)
        labelBackgroundColor = UIColor .whiteColor()
        labelTextColor = UIColor.blackColor()
        progressIndicatorBackgroundColor = UIColor.redColor()
        
        indicatorLegend = UIView()
        indicatorLegend.translatesAutoresizingMaskIntoConstraints = false
        indicatorLegend.layer.cornerRadius = legendDimension/2.0
        indicatorLegend.backgroundColor = legendBackgroundColor
        indicatorLegend.layer.borderWidth = progressIndicatorBorderWidth
        indicatorLegend.layer.borderColor = progressIndicatorBorderColor.CGColor
        indicatorLegend.hidden = !showLegendView
        
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
        progressIndicatorForegroundView.layer.borderWidth = progressIndicatorBorderWidth
        progressIndicatorForegroundView.layer.borderColor = progressIndicatorBorderColor.CGColor
        
        progressIndicatorBackgroundView.layer.cornerRadius = progressIndicatorHeight/2.0
        progressIndicatorForegroundView.layer.cornerRadius = progressIndicatorHeight/2.0
        
        self.progressIndicatorForegroundViewWidthConstraint = NSLayoutConstraint(item: progressIndicatorForegroundView, attribute: .Width, relatedBy: .Equal, toItem: progressIndicatorBackgroundView, attribute: .Width, multiplier: CGFloat(fractionValue), constant: 1.0)
        
        super.init(frame: frame)
        
        self.addSubview(progressIndicatorBackgroundView)
        self.addSubview(progressIndicatorForegroundView)
        self.addSubview(percentageCounterLabel)
        self.addSubview(indicatorLegend)
        
        let views = ["progressIndicatorBackgroundView": progressIndicatorBackgroundView, "progressIndicatorForegroundView": progressIndicatorForegroundView, "percentageCounterLabel": percentageCounterLabel, "indicatorLegend": indicatorLegend]
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
        
        // Constraints for legend indicator view.
        self.addConstraint(NSLayoutConstraint(item: indicatorLegend, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: legendDimension))
        self.addConstraint(NSLayoutConstraint(item: indicatorLegend, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: legendDimension))
        self.addConstraint(NSLayoutConstraint(item: indicatorLegend, attribute: .CenterY, relatedBy: .Equal, toItem: progressIndicatorForegroundView, attribute: .CenterY, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: indicatorLegend, attribute: .Trailing, relatedBy: .Equal, toItem: progressIndicatorForegroundView, attribute: .Trailing, multiplier: 1.0, constant: legendDimension/2.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(currentValue: Int, maximumValue: Int) {
        self.init(frame: CGRectZero, currentValue: currentValue, maximumValue: maximumValue, titleDirection: .Top, progressIndicatorHeight: 20)
    }
    
    func fractionStringFromCurrentValue(currentValue: Int) -> String {
        let fractionValue = Float(currentValue)/Float(maximumValue)
        return String(format: "%d", Int(fractionValue * 100.0))
    }
    
    func showLabelWithDuration(animationDuration: NSTimeInterval, labelFormatterClosure: ((Int, String) -> ())?, completionClosure: (() -> Void)?) {
        
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
                    let labelValue = self.fractionStringFromCurrentValue(i)
                    self.percentageCounterLabel.text = labelValue
                    if let labelIntValue = Int(labelValue) {
                        labelFormatterClosure?(labelIntValue, labelValue)
                    }
                });
            }
            completionClosure?()
        };

    }
    
}
