<p align="center">
<img src="https://raw.githubusercontent.com/Flinesoft/Imperio/stable/Logo.png"
width=600 height=167>
</p>

<p align="center">
  <a href="https://app.bitrise.io/app/b2ccbd0bd00feffd">
  <img src="https://app.bitrise.io/app/b2ccbd0bd00feffd/status.svg?token=mpeSdr3KWt40nfKtW134wg&branch=stable"
     alt="Build Status">
  </a>
  <a href="https://codebeat.co/projects/github-com-flinesoft-imperio">
  <img src="https://codebeat.co/badges/cb963269-61e6-40c9-85b7-c57a73dde3ee"
     alt="codebeat badge">
  </a>
  <a href="https://github.com/Flinesoft/Imperio/releases">
  <img src="https://img.shields.io/badge/Version-3.0.0-blue.svg"
     alt="Version: 3.0.0">
  </a>
  <img src="https://img.shields.io/badge/Swift-4.2-FFAC45.svg"
     alt="Swift: 4.2">
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

The goal of this library is to **keep view controllers lean & make them easily testable** by getting screen flow and other responsibilities out of them. Instead flow controllers are used to handle screen flow and trigger changes in the view, which the view controller handles. Pattern wise this approach combines ideas from MVC, MVP, MVVM, VIPER & [Lotus](https://matteomanferdini.com/ios-architecture-lotus-mvc-pattern).


## Installation

Installing via [Carthage](https://github.com/Carthage/Carthage#carthage) & [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) are both supported.

Support for SPM is currently not possible as this framework uses UIKit.

## Usage

Below you find a step by step guide on how to use Imperio. There's also a demo project which you can check out to see what it all looks like put together. The example code in the explanations below are all part of the demo project.

### FlowController

The first step when using Imperio is to lean back and **think for a moment about your screen flow**. You don't need to recognize each screen that'll be part of your screen flow, instead you should concentrate on which use cases you have and simply write exactly one flow controller for each use case. For example, the onboarding or tutorial could be one screen flow, although it might consist of one or multiple screens and view controllers.

Once you've got an initial list of screen flows (or the first), name it and write a subclass using that name. Let's make a flow controller that manages the tutorial on first start of the app. A flow controller needs to be a subclass of `FlowController`:

``` Swift
import Imperio

class TutorialFlowController: FlowController {
    // TODO: not yet implemented
}
```

### The `start(from:)` method

Each coordinator subclass needs to override at least the `start` method which opens the initial view controller of the screen flow. For example:

``` Swift
import Imperio

class TutorialFlowController: FlowController {
    private var navigationCtrl: UINavigationController?
    
    override func start(from presentingViewController: UIViewController) {
        let page1ViewCtrl = Page1ViewController()
        navigationCtrl = UINavigationController(rootViewController: page1ViewCtrl)
        
        // TODO: set up the flow delegate
        
        presentingViewController.present(navigationCtrl!, animated: true)
    }
}
```

Please note that within the `start` method you should:

- initialize your first view controller
- setup the flow delegate (will be explained later)
- present your first view controller

### Sub Flow Controllers

Now, whenever you might want to start your screen flow from within another flow controller, you would do this:

``` Swift
func tutorialStartButtonPressed() {
    let tutorialFlowCtrl = TutorialFlowController()
    add(subFlowController: tutorialFlowCtrl)
    tutorialFlowCtrl.start(from: someViewController!)
}
```

Please note that this works pretty much like adding a subview to a `UIView` with `myView.addSubview(subview)`: You add the sub flow controller and start it. Once you're done with the screen flow, you dismiss your last view controller and remove the sub flow controller from its super flow controller by calling `removeFromSuperFlowController()`. For example:

``` Swift
func completeButtonPressed() {
    navigationCtrl?.dismiss(animated: true) {
        self.removeFromSuperFlowController()
    }
}
```

### InitialFlowController

There's one special case for flow controllers: The initial screen flow to be started on app launch. As there's no view controller to be presented _from_ on app launch, we can't use the above `start(from:)` method which requires a view controller. Instead, if you're defining the initial flow controller, you need to make three small changes:

1. Subclass `InitialFlowController` instead of `FlowController`.
2. Override `start(from window: UIWindow)` instead of `start(from presentingViewController: UIViewController)`.
3. Set the `rootViewController` of the `window` instead of presenting the first view controller.

That's all difference there is. Here's an example of what the above example would look like with these changes:

``` Swift
import Imperio

class TutorialFlowController: InitialFlowController {
    private var navigationCtrl: UINavigationController?
    
    override func start(from window: UIWindow) {
        let page1ViewCtrl = Page1ViewController()
        navigationCtrl = UINavigationController(rootViewController: page1ViewCtrl)
        
        // TODO: set up the flow delegate
        
        window.rootViewController = navigationCtrl
    }
}
```

### Flow Delegate

In order for the flow controller to get notified of any actions of the user, the view controller needs to define a class protocol of the possible actions. This should usually be done right at the top of the view controller classes file. Then in your view controller, you define a `weak var flowDelegate` property with the protocol type. For example:

``` Swift
protocol Page1FlowDelegate: class {
    func nextToPage2ButtonPressed()
}

class Page1ViewController: UIViewController {
    weak var flowDelegate: Page1FlowDelegate?

    // TODO: action not yet implemented
}
```

Note that the actions names should not contain any semantics about the screen flow: Always use `nextToPage2ButtonPressed()` which is what the user really did instead of `showNextScreen` which already includes semantics of what to do next. It is up to the flow controller to decide what to do next, not the view controllers!

Of course, when the interaction is done we need to call our delegate methods in order to coordinate the responsibility of what to do next to the flow controller:

``` Swift
class Page1ViewController: UIViewController {
    // ...

    @IBAction func nextButtonPressed() {
        flowDelegate?.nextToPage2ButtonPressed()
    }
}
```

Last, our flow controller needs to react to those delegate methods. This is a two-step process. First step is to make the flow controller comply to the `Page1FlowDelegate` protocol:

``` Swift
extension TutorialFlowController: Page1FlowDelegate {
    func nextToPage2ButtonPressed() {
        let page2ViewCtrl = Page2ViewController()
        navigationCtrl?.pushViewController(page2ViewCtrl, animated: true)
    }
}
```

Second step is to set the flow controller as the flow delegate of the view controller. For the initial view controller this needs to be done in the `start(from:)` method. So let's replace the TODO in there like this:

``` Swift
override func start(from presentingViewController: UIViewController) {
    // ...
    
    page1ViewCtrl.flowDelegate = self

    // ...
}
```

That's it. Everything is set up and should work now. The flow controller manages the screen flow!

## FAQ

### How do I start the initial flow controller from my AppDelegate?

Here's an example how this might look like:

``` Swift
import Imperio
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var initialFlowController: InitialFlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        initialFlowController = MainFlowController()
        initialFlowController?.start(from: window!)

        return true
    }
}

```

Note that you need to call `makeKeyAndVisible()` on the window. Otherwise you might just see a black screen. Also make sure you are subclassing `InitialFlowController` instead of `FlowController`. Refer to the [`InitialFlowController`](#initialflowcontroller) section above on how to do this.

### How can I pass data between flow controllers?

There are two different cases here:
- passing data **into** a flow controller
- passing data **back** to a super flow controller

The **first case** is simple: Add a property to the flow controller to pass into and add a parameter to its `init` method. Or in other words: Just use Swift. For example:

``` Swift
class EditProfileFlowController: FlowController {
    private let profile: Profile

    init(profile: Profile) {
        self.profile = profile
        super.init()
    }
}
```

The **second case** is a little more work. Add a property to the flow controller to pass back from and add a parameter to its `init` method. Or in other words: Do the exact same thing as above. But this time, it's a closure. For example:

``` Swift
class ImagePickerFlowController: FlowController {
    typealias ResultClosure = (UIImage) -> Void

    let resultCompletion: ResultClosure

    init(resultCompletion: @escaping ResultClosure) {
        self.resultCompletion = resultCompletion
        super.init()
    }
    
    // ...
}
```

The usage side then would look like this:

``` Swift
func imagePickerStartButtonPressed() {
    let resultCompletion = SafeResultClosure<UIImage>(self) { (self, pickedImage) in
	       // do something with the result
    }

    let imagePickerFlowCtrl = ImagePickerFlowController(resultCompletion: resultCompletion)
    add(subFlowController: imagePickerFlowCtrl)
    imagePickerFlowCtrl.start(from: mainViewController!)
}
```

The `SafeResultClosure` is a wrapper which you pass a strong reference of `self` to and get a strong reference of `self` back from as the first parameter. The closure will only be called if `self` is not `nil`. This way you can prevent writing `[weak self]` or `[unowned self]` in the closure parameters list so – you get safety by default.

`SafeResultClosure` is part of Imperio and is an implementation of the Delegated pattern described [here](https://medium.com/anysuggestion/preventing-memory-leaks-with-swift-compile-time-safety-49b845df4dc6).

### How can I pass data between a flow controller and its view controllers?

There are two different cases here:
- passing data **into** view controllers
- passing data **back** to the flow controller

**For passing data into view controllers** we recommend using structs that represent the view state. We call them `ViewModel`s. Here's a simple view model:

```
struct MainViewModel {
    let backgroundColor: UIColor
    var pickedImage: ObservableProperty<UIImage?>
}
```

Note that for properties that don't change we are simply using a let and the type directly. For properties that might change over time we are using the `ObservableProperty` wrapper. It's part of Imperio and allows the view controller to subscribe to any changes of the property and react accordingly. Just put your view model into your view controller like so:

``` Swift
class MainViewController: UIViewController {
    // ...
    var viewModel: MainViewModel?
    // ...
}
```

Now in your `viewDidLoad()` method you can use the constant properties directly and observe the variable ones like so:

``` Swift
@IBOutlet private var pickedImageView: UIImageView!

override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = viewModel?.backgroundColor

    _ = viewModel?.pickedImage.didSet(self) { (self, pickedImage) in
        self.pickedImageView.image = pickedImage
    }
}
```

The strong `self` which is passed into the `didSet()` is safely returned back as a strong `self` as the parameter of the closure. (It's converted to a weak self automatically by Imperio internally.)

Whenever you want to change the `pickedImage` property, simply use the `setValue()` method of the `ObservablePropertly` like so:

``` Swift
mainViewController.viewModel.pickerImage.setValue(pickedImage)
```

As for the second case – **passing data back to the flow controller** – simply add parameters to your flow delegate methods. For example:

``` Swift
protocol AddressListFlowDelegate: class {
    func didSelectEntry(at index: NSIndexPath)
    func searchFieldTextChanged(to text: String)
}
```

### Now that my view controllers are lean, how do I test them?

If you followed our suggestion and created a view model that defines the view state of your view controller, then here's how:

- Initialize a view controller.
- Set its `viewModel` property to a state you want to test.
- Take a snapshot of the view controllers `view` property and verify that it didn't change.

The last step is done using the framework [FBSnapshotTestCase](https://github.com/facebookarchive/ios-snapshot-test-case). Here's a complete example from the demo project:

``` Swift
import Bond
import FBSnapshotTestCase
@testable import Imperio_Demo
import UIKit

class MainViewControllerTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }

    func testRedBackgroundWithHogwartsImage() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? MainViewController
        mainViewController?.viewModel = MainViewModel(backgroundColor: .red, pickedImage: ObservableProperty(#imageLiteral(resourceName: "hogwarts")))
        FBSnapshotVerifyView(mainViewController!.view)
    }
}
```

### How do I deal with container view controllers like UINavigationController or UITabBarController?

If you happen to come across types which already encapsulate some portion of the screen flow, don't try to force-fit them into the structure suggested here. Also don't create view controllers as wrappers just to get handling their delegates out of the flow controller. It is absolutely valid to deviate from the way of passing data or the separation of responsibilities in some circumstances. For example, this is valid:

``` Swift
class ImagePickerFlowController: FlowController {
    override func start(from presentingViewController: UIViewController) {
        presentingViewController.present(instantiateSourceChooser(from: presentingViewController), animated: true)
    }

    func instantiateSourceChooser(from viewController: UIViewController) -> UIAlertController {
        let alertCtrl = UIAlertController(title: "Choose source.", message: "How do you want to choose your image?", preferredStyle: .actionSheet)

        alertCtrl.addAction(UIAlertAction(title: "Camera", style: .default) { [unowned self] _ in
            self.startCamera(from: viewController)
        })

        alertCtrl.addAction(UIAlertAction(title: "Albums", style: .default) { [unowned self] _ in
            self.startImagePicker(from: viewController)
        })

        alertCtrl.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [unowned self] _ in
            self.removeFromSuperFlowController()
        })

        return alertCtrl
    }
}
```

The `UIAlertViewController` class is already one that encapsulates how it is rendered. We are simply passing some data here and can't create a view model for it, as the API of the controller is defined differently (with `addAction` methods). Or another example:

``` Swift
class ImagePickerFlowController: FlowController {
    // ...

    func startCamera(from viewController: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
    
        imagePicker.delegate = self
        viewController.present(imagePicker, animated: true)
    }
    
    func startImagePicker(from viewController: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
    
        imagePicker.delegate = self
        viewController.present(imagePicker, animated: true)
    }
}

extension ImagePickerFlowController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.removeFromSuperFlowController()
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            resultCompletion.reportResult(result: pickedImage)
            picker.dismiss(animated: true) {
                self.removeFromSuperFlowController()
            }
        }
    }
}
```

The `reportResult()` method is part of `SafeResultClosure` and must be used to report the result once it is available.

We are dealing with the image picker source types and its delegates methods directly in the flow controller. It is not needed to create extra types to get them out of the flow controller. The `UIImagePickerController` is already a well tested view controller, we just need to comply to its interface. The same is true for `UITabBarController`, `UINavigationController` and `UISplitViewController`.

### How do I (further) prevent a "Massive View/Flow Controller" problem?

Letting your ViewControllers only deal with view logic by moving the flow control to FlowControllers is an important first step. But you might find yourself in a situation, where much of the code which was previously part of your ViewControllers now just moved to your FlowController or where your ViewController is still massive due to complex UI handling.

To prevent these issues, we can apply an idea from the [Lotus](https://matteomanferdini.com/ios-architecture-lotus-mvc-pattern/#section2) pattern: **ModelControllers**.

ModelControllers can take the responsibility of bringing the data to the view controllers off the FlowControllers. There are two kinds of ModelControllers: Shared and View-specific ones.

Typical responsibilities for **shared ModelControllers** are:

- managing network requests (API, Logger, Analytics)
- accessing storage systems (Files, Core Data, UserDefaults)
- reading sensor data (GPS, gyroscope, accelerometer)

Typical responsibilities for **specific ModelControllers** are:

- implementing UITableViewDataSource & UICollectionViewDataSource
- state machines for complex view controller logic

Shared ModelControllers are typically globally reachable and could use the [Singleton pattern](https://cocoacasts.com/what-is-a-singleton-and-how-to-create-one-in-swift/). Both your ViewControllers and FlowControllers could therefore use them. View-specific ModelControllers are typically only needed for more complex ViewControllers and are created by them as well as hold a strong reference to them.

So, use ModelControllers wherever you might need them to prevent the Massive Flow/View Controller problem.

## Contributing

See the file [CONTRIBUTING.md](https://github.com/JamitLabs/MungoHealer/blob/stable/CONTRIBUTING.md).


## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
