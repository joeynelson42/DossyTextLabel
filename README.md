# DossyTextLabel 📟
> A subclass of UILabel reminiscent of [Strong Bad's faithful Tandy 400](http://www.homestarrunner.com/sbemail10.html) and MS-DOS of yore.


![](https://media.giphy.com/media/b7HBTefES2Rpe/giphy.gif)



## Requirements

- Swift 3.0
- iOS 8.0+
- Xcode 8.0

## Installation

#### CocoaPods ☕️
You can use [CocoaPods](http://cocoapods.org/) to install `DossyText` by adding it to your `Podfile`:

```ruby
pod 'DossyText'
```

To get the full benefits import `DossyText` wherever you import UIKit:

``` swift
import UIKit
import DossyText
```

## Usage

Simply create an instance of DossyTextLabel and add it to your view hierarchy in yo:
```swift
let dossyLabel = DossyTextLabel()
```

Modify it as you would any UILabel:
```swift
dossyLabel.textColor = UIColor.cyan
dossyLabel.numberOfLines = 0
dossyLabel.lineBreakMode = .byWordWrapping
```


...and type away! ⌨️:
```swift
dossyLabel.type("Hello world!\nHow are you today?")
```

### More granular modifications

Adjust the speed of the typing by changing ```millisecondsPerLetter```. 70 is a pretty good place to start 🏃🏼.

## Meta(l!!!)

Joey Nelson – [@jedmondn](https://twitter.com/jedmondn) – joeyedmondnelson@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.
