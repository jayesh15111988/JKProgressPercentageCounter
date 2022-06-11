# JKProgressPercentageCounter
**A animating label counter to show completion progress and total percentages with interactive animation**

![alt text][ProgressPercentageCounter]

[ProgressPercentageCounter]: https://github.com/jayesh15111988/JKProgressPercentageCounter/blob/master/Progress_Indicator_Demo.gif "A demo for animated progress percentage counter label"

### Documentation : 

_The idea about making this library came to my mind while working on one of work projects. While partially working on it I realized how
difficult it could be to make such animation. Code itself is not challenging to write, but I faced some challenges in terms of code
architecture and customization. Hope I have added enough customizable properties to this library. If not, do let me know or 
I will appreciate if you could send a pull request._

#### Initializing Percentage counter

You can initialize progress percentage counter with initializer

`let progressIndicatorView = JKProgressPercentageCounterView(frame: <counter_view_frame_size>, currentValue: <current_value>, maximumValue: <maximum_value>, titleDirection: <title_direction>, progressIndicatorHeight: <progress_indicator_height>)`

If you want to use default library provided parameters, you can also use a convenience initializer,

`let progressIndicatorView = JKProgressPercentageCounterView(currentValue: <current_value>, maximumValue: <maximum_value>)`

There are tow ways you can show the percentage counter label.

#### With animation

```
individualView.showLabelWithDuration(<animation_duration>, labelFormatterClosure: {labelValueInt, labelValueString in
                print("Label value is \(labelValueString)")
                }, completionClosure: {
                    print("Completed Animation")
            })
```

#### If you don't want to show the animation, you can simple avoid the last line of code. Create an instance of `JKProgressPercentageCounterView`
and add it to the view.

__Note: It is highly recommended that you use autolayout with this library. `autoresizingMask` is turned off for all the subviews
of this library. You can also pass the manual `CGRect` in the initializer. It's just that view will not play nice on variable sized devices__

### You can customize following properties. Some of them are set in the initializer. There are two types of initializers as follows. 
One if a regular one another one is convenience initializer which takes care of setting up default values for unspecified parameters.

__Initializer__
`init(frame: CGRect, currentValue: Int, maximumValue: Int, titleDirection: TitleDirection, progressIndicatorHeight: CGFloat)`

__Convenience Initializer__
`convenience init(currentValue: Int, maximumValue: Int)`

### Customizable paramters and default values

* `titleDirection` - Specifies where the percentage title label lies with respect to progress indicator view. Default to top position
* `currentValue` - Value to show on completion label. Percentage is calculated from maximum value
* `maximumValue` - Maximum value for given calculation. Used to calculate and display percentage on counter label
* `progressIndicatorShape` - The shape of progress indicator at the end. Default to Circle
* `progressIndicatorHeight` - Height of progress indicator completion view. Defaults to 20
* `progressIndicatorBorderColor` - Border color for progress indicator. Defaults to `lightGrayColor`
* `progressIndicatorBorderWidth` - Border width of progress indicator. Defaults to 0.5
* `originalLabelValue` - This is the original label value. This is string representation of percentages calculated out of currentValue and maximumValue as supplied by user
* `updatedLabelValue` - Sometimes user might want to apply formatting to originalLabelValue. This property could be used to update it

   For example, if not using animation - 
   `progressIndicatorView.updatedLabelValue = "\(progressIndicatorView.originalLabelValue) out of 1000"`
   
   if using animation this values could be specified in the `labelFormatterClosure` passed while creating animation block as follows
   ```
individualView.showLabelWithDuration(<animation_duration>, labelFormatterClosure: {labelValueInt, labelValueString in
                progressIndicatorView.updatedLabelValue = "\(labelValueString) out of 1000"
                }, completionClosure: {
                    print("Completed Animation")
            })
   ``` 
  
* showLegendView - Legend is a small view attached at the end of progress indicator view. This property can be used to turn it
on or off. Defaults to `false`

* legendBackgroundColor - A background color for our legend view. Default to `purpleColor`

* completionCallback - Users can also set the completion block while animating label with

   ```
   showLabelWithDuration(animationDuration: NSTimeInterval, labelFormatterClosure: ((Int, String) -> ())?, completionClosure: (() -> Void)?)
   ```
   
   This closure gets called as soon as the progress percentage counter label animation is finished.
* animationDuration - This is the animation duration for both progress indicator and label values counter.

_You can include this library in your iOS project by adding following line to the podfile_ <br/>
 `pod 'JKProgressPercentageCounter', :git => 'https://github.com/jayesh15111988/JKProgressPercentageCounter.git'` and running `pod update` thereafter


> For convenience, I have added a demo along with this library. You can get hang of extra parameters and other ways to customize the appearance of animating percentage
labels. I have tried to add demo for every possible major scenario. Let me know if something is missing or needs more clarification or attention
