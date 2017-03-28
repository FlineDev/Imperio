<p align="center">
<img src="https://raw.githubusercontent.com/Flinesoft/Imperio/stable/Logo.png"
width=600 height=167>
</p>

<p align="center">
  <a href="https://www.bitrise.io/app/2f9c88bb42720cb1">
  <img src="https://www.bitrise.io/app/2f9c88bb42720cb1.svg?token=dZVzs771PljV_kKatagpJg&branch=stable"
     alt="Build Status">
  </a>
  <a href="https://codebeat.co/projects/github-com-flinesoft-imperio">
  <img src="https://codebeat.co/badges/cb963269-61e6-40c9-85b7-c57a73dde3ee"
     alt="codebeat badge">
  </a>
  <a href="https://github.com/Flinesoft/Imperio/releases">
  <img src="https://img.shields.io/badge/Version-1.0.0-blue.svg"
     alt="Version: 1.0.0">
  </a>
  <img src="https://img.shields.io/badge/Swift-3.0-FFAC45.svg"
     alt="Swift: 3.0">
  <img src="https://img.shields.io/badge/Platforms-iOS%20%7C%20tvOS-FF69B4.svg"
     alt="Platforms: iOS | tvOS">
  <a href="https://github.com/Flinesoft/Imperio/blob/stable/LICENSE.md">
  <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg"
     alt="License: MIT">
  </a>
</p>

<p align="center">
<a href="#installation">Installation</a>
• <a href="#usage">Usage</a>
• <a href="https://github.com/Flinesoft/Imperio/issues">Issues</a>
• <a href="#contributing">Contributing</a>
• <a href="#license">License</a>
</p>


# Imperio

The goal of this library is to **keep view controllers lean** by getting screen flow and data handling logic out of them. Instead coordinators are used to handle screen flow and trigger data handling. This idea is explored in detail by Soroush Khanlou in [this great post](http://khanlou.com/2015/10/coordinators-redux/). Go ahead and read it now if you haven't already!


## Installation

Currently the recommended way of installing this library is via [Carthage](https://github.com/Carthage/Carthage).
[Cocoapods](https://github.com/CocoaPods/CocoaPods) is supported, too.
[Swift Package Manager](https://github.com/apple/swift-package-manager) might work, too (not tested).

You can of course also just include this framework manually into your project by downloading it or by using git submodules.

### Carthage

Place the following line to your Cartfile:

``` Swift
github "Flinesoft/Imperio"
```

Now run `carthage update`. Then drag & drop the Imperio.framework in the Carthage/Build folder to your project. Now you can `import Imperio` in each class you want to use its features. Refer to the [Carthage README](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) for detailed / updated instructions.

### CocoaPods

Add the line `pod 'Imperio'` to your target in your `Podfile` and make sure to include `use_frameworks!`
at the top. The result might look similar to this:

``` Ruby
platform :ios, '8.0'
use_frameworks!

target 'MyAppTarget' do
  pod 'Imperio', '~> 1.0'
end
```

Now close your project and run `pod install` from the command line. Then open the `.xcworkspace` from within your project folder.
Build your project once (with `Cmd+B`) to update the frameworks known to Xcode. Now you can `import Imperio` in each class you want to use its features.
Refer to [CocoaPods.org](https://cocoapods.org) for detailed / updates instructions.

## Usage

### Coordinator

The first step when using Imperio is to lean back and **think for a moment about your screen flow**. You don't need to recognize each screen that'll be part of your screen flow, instead you should concentrate on which use cases you have and simply write exactly one coordinator for each use case. For example, the onboarding or tutorial could be one screen flow, although it might consist of one or multiple screens and view controllers.

Once you've got an initial list of screen flows (or the first), name it and write a subclass using that name. Let's make a coordinator that manages the tutorial on first start of the app. A coordinator needs to be a subclass of `Coordinator`:

``` Swift
import Imperio

class TutorialCoordinator: Coordinator {
    // TODO: not yet implemented
}
```

#### The `start` method

Each coordinator subclass needs to override at least the `start` method which opens the initial screen of the screen flow and the `mainViewController` property, which will be used to dismiss the current screen flow. For example:

``` SWift
private var page1Ctrl: TutorialPage1ViewController!
override var mainViewController: UIViewController? {
    return page1Ctrl
}

override func start() {
    super.start()
    page1Ctrl = TutorialPage1ViewController()

    // TODO: setup coordinator actions

    present(page1Ctrl)
}
```

Please note that within the `start` method you should:

- call `super.start()`
- initialize your initial view controller
- setup the coordinator actions (will be explained later)
- call `present(_ viewCtrl:style:navigation:)` method

#### The `present` method

The `present` method of the Coordinator class is used to present any view controller within the screen flow of the current coordinator. You can call it without any configuration like this:

``` Swift
present(page1Ctrl)
```

This will check if the given view controller is part of the current navigation stack (if any) and push it if it finds it, or otherwise present a modal view controller with a auto-generated navigation controller (if the given view isn't a navigation controller itself).

To present a view controller modally **without** a navigation controller, set the `navigation` option to `false`:

``` Swift
present(page1Ctrl, navigation: false)
```

To explicityly state the expected presentation style, set the `style` option to either `modal` or `push`:

``` Swift
present(page1Ctrl, style: .modal(completion: nil))
// or
present(page1Ctrl, style: .push)
```

Note that for the `.modal` presentation style you can set a completion closure which will be called once the presentation has finished.

### Coordinatable

In order for the coordinator to get notified of any actions of the user, the view controller needs to comply to `Coordinatable`. In order to do that, you should first create an enum with some actions that can be done by the user within the view controller and name it `Action`:

``` Swift
class TutorialPage1ViewController: Coordinatable {
    enum Action {
      case nextButtonPressed
      case didEnterName(String)
      case skipButtonPressed
    }
    // TODO: not yet completed
}
```

Note that the actions names should not contain any semantics: Always use `nextButtonPressed` which is what the user really did instead of `showNextScreen` which already includes semantics and probably is what the user intended. It is up to the coordinator to decide the intention of the user, not the view controllers!

Now we can complete making our view controller comply to `Coordinatable` (note that when you simply type `coordinate` Xcode will auto-complete the rest of the code here):

``` Swift
class TutorialPage1ViewController: Coordinatable {
    // the `Action` enum code is here
    var coordinate: ((TutorialPage1ViewController.Action) -> Void)!
}
```

That's it on the controller side. This enables us to complete our coordinators `start` method (the TODO part):

``` Swift
override func start() {
    // ...
    page1Ctrl.coordinate = { [unowned self] action in
        switch action {
        case .nextButtonPressed:
            self.showNextScreen() // present next view controller using the present method
            
        case .didEnterName(let name):
            self.changeName(to: name) // update your data based on input
            
        case .skipButtonPressed:
            self.finish() // finish the current screen flow
    }
    // ...
}
```

The `coordinate` closure is the place the coordinator gets notified about any actions the user made in view controller. So, make sure to call it when user actions are perceived in your view controller, for example:

``` Swift
@IBAction func nextButtonPressed() {
    coordinate(.nextButtonPressed)
}

```

Also note that the `finish` method (called on when the skip button is pressed) will dismiss the main view controller of the coordinator and therefore complete the current screen flow.


### App Coordinator

To keep the AppDelegate clean, create a subclass of `AppCoordinator` instead of `Coordinator`. It works just like a coordinator (in fact it's a subclass of `Coordinator`), only that it can be presented from the App Delegate. Actually, you can make any of your coordinators the app coordinator through two simple steps:

- Subclass `AppCoordinator` instead of `Coordinator`
- Call `present(initialViewController: homeViewCtrl)` instead of `present(homeViewCtrl)` in your start method

Note that you can't `finish` the screen flow of an app coordinator. Imperio will simply do nothing if you call it.

Now your AppDelegate can look something like this:

``` Swift
import UIKit
import Imperio

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appCoordinator: AppCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        appCoordinator = DashboardCoordinator()
        appCoordinator?.start()
        window = appCoordinator?.window

        return true
    }
}
```

### Sub Coordinators

To start a different screen flow from within a screen flow you need to call the `start(subCoordinator:)` method:

``` Swift
let tutorialCoordinator = TutorialCoordinator() 
start(subCoordinator: tutorialCoordinator)
```

If you want to get notified when the sub coordinator is finished or disappeared, simply chain `onFinish` or `onDisappear` callbacks to the start method:

``` Swift
start(subCoordinator: tutorialCoordinator).onFinish {
    myTableViewController.reloadData()
}
```

If you ever need to pass data into a coordinator on creation, simply write a new `init` method with all the data needed to be passed like this:

``` Swift
class TutorialCoordinator {
    private let name: String
    init(presentingViewController: UIViewController, name: String) {
        self.name = name
        super.init(presentingViewController: presentingViewController)
    }
}
```

### The Navigation Controller Issue

One problem that arises in navigation controllers is that there is implicit screen flow logic supported by iOS by default: The back button press and the swipe gesture to navigate between view controllers in the navigation stack. To solve this, you should add a `didDisappear` case to the view controllers possible actions and call `coordinate(.didDisappear)` in the view controllers `viewDidDisappear`:

``` Swift
override func viewDidDisappear(_ animated: Bool) {
    if navigationController == nil || !navigationController!.viewControllers.contains(self) {
        coordinate(.didDisappear)
    }

    super.viewDidDisappear(animated: animated)
}
```


## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion.

Please also try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)).


## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
