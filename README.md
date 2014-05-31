#MQTextField
MQTextField is a replacement control for UITextField that provides several useful features, including:
* Helper init methods
* Form validation
* More coming soon...

#Preview
![MQTextField Screenshot](https://cloud.githubusercontent.com/assets/1660882/3137871/c0c76e62-e860-11e3-8a61-1833920caa76.png)

#Installation

##CocoaPods
The easiest and highly recommended way to add DPTextField to your project is to use [CocoaPods](http://cocoapods.org/).

Add the pod to your `Podfile`:
```
platform :ios, '7.0'
pod 'MQTextField'
```
then run `pod install`.

Be sure to `#import "MQTextField.h"`. Then, you can swap out `UITextField` for `MQTextField`. Definitely check out the Sample app to understand how the validation should be implemented within the view controller.

###Source
Alternatively, you can clone this repository and add the 2 files in the Code directory to your project.

#Contributing
Feel free to fork and send pull requests. It might be nice to have more styles for the textfields, i.e., icons for forms.

#License
Usage is provided under the [MIT License](http://http//opensource.org/licenses/mit-license.php). See LICENSE for the full details.

#Credit
A mention would be nice, but is by no means required. At the very least, shoot us an email and let us know if you've gotten any good use out of this control, or if you have any ideas for improvements.
