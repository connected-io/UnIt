![unit](https://user-images.githubusercontent.com/37081225/52099779-95d1e000-25a2-11e9-87f8-1447a0983a66.png)
> Oh ma goodness, UnIt is just an absolute unit 🔥🔥🔥 - Anonymous

Unit tests are great for testing business logic and your models. However, it get's a little cumbersome when you are trying to test view specific logic due to boilerplate code, drilling through multiple view layers or UIKit laziness. This framework attempts to ease some of that pain away with helpful extensions on your favourite classes like **UIView**, **UIViewController** and more! By having your UI able to be easily validated by unit tests, we can capture visual bugs before we get shamed by our QA department :( 

## Warning
This library uses the black magic of swizzling for one of the extensions (capturing constraints). Please be cognizant of this as Apple can change the underlying objective-C private method that this extension swizzles anytime. In addition, you will most likely get an App Store rejection if this framework is included in your app target. It's recommended to keep this framework only in your test target.

## Installation
Will support Cocoapods, Carthage and Swift Package Manager in the near future!

## Removing UIViewController Boilerplate Code
When creating a view controller in unit tests, UIKit decides to be lazy and does the least possible work possible. In unit tests, the view lifecycle method - **viewDidLoad**, **viewWillAppear**, **viewDidAppear** are not guaranteed to be invoked. This results in developers doing stuff like getting the key window, attach the view controller to the key window and make it key and visible - blegh.

Instead we can use this extension on **UIViewController**:
```swift
func kickUIKit(for device:Device)
```
Example:
```swift
beforeEach {
  // Instantiate view controller (subject) with your custom instantiation code.
  subject.kickUIKit(for: Device.iPhoneXS)
}
```
This function guarantees that the view controller's view lifecycle will run properly with the given iOS device size.

## Finding UI Elements
Let's say we want to check if our view controller has a table view cell with the text - "Toronto Raptors" in our test. This is how we would do it the old-fashioned way.

```swift
it ("should have a table view cell that contains the text 'Toronto Raptors'") { 
  expect(subject.tableView.visibleCells[0].textLabel?.text).to(equal("Toronto Raptors"))
}
```
Sure we have 1 line for this test, but what crimes do we commit in this 1 line? Drilling through multiple view layers and having an intimate knowledge of the implementation of this view controller.

Instead, we can use our extension on **UIView**:
```swift
func firstVisibleTableViewCell(with text: String) -> UITableViewCell?
```
Let's write our test again:
```swift
it ("should have a table view cell that contains the text 'Toronto Raptors'") {
  expect(subject.view.firstVisibleTableViewCell(with: "Toronto Raptors")).notTo(beNil())
}
```
Once again it's a 1 liner, but we solve the issue of not commiting the treacherous crimes that we commited in the previous example. Also, it reads more like a conversation and is easier to understand what the function is asking - "Give me the first table view cell in the subject's view that contains the text 'Toronto Raptors'.".

There are more convenience extension methods that apply to **UILabel**, **UIButton** and **UICollectionViewCell**. If you want to go subclass view hunting you can use this method:
```swift
func firstView<T: UIView>(ofType type: T.Type, passing test: (T) -> Bool) -> T?
```
Example:
```swift
return myView.firstView(ofType: MyCustomView.self, passing: { $0.titleLabel.text == "Drake is the greatest" && $0.backgroundColor = UIColor.blue } )
```
The example above states that within **myView**, return the first subview that is a **MyCustomView** class with the titleLabel text of "Drake is the greatest" and has a blue background color.

## Capturing Constraints
Constraint breaks are one of the top 5 most unenjoyable experiences an iOS developer can experience. All we get is a system log of all the conflicting constraints that shames us and is hard to read.

We can use our extension on **UIViewController**:
```swift
public var conflictingConstraints: [[NSLayoutConstraint]]
```
Example:
```swift
context("When the view controller has finished laying out") {
  it("should have no conflicting constraints") {
    expect(subject.conflictingConstraints).to(beEmpty())
  }
}
```
It may not be easier to read, but we now can have our conflicting constraints captured by our unit tests / CI which makes this really neat.

**Note**: In order to capture constraints, we partake in the black magic of swizzling. Use this at your own risk. The private method could be changed or deprecated at any time by Apple.

## Capturing Overlaps
How often have you run into the problem that your app looks great on one screen size, but looks like an overlapped, jumbled mess on a smaller screen size or when accessibility is turned on?

We can use our extension on **UIViewController**:
```swift
public func overlappingSubviews(whiteList: [UIView] = []) -> [Set<UIView>:CGRect] 
```
Example:
```swift
context("When the view controller has finished laying out") {
  it("should have no views that overlap") {
    expect(subject.overlappingSubviews()).to(beEmpty())
  }
}
```
This function checks the view controller's subviews to see if any views overlaps. What we get is a dictionary where each key is a pair of views that overlap and the value is a CGRect of where they overlap in the screen's coordinate space. It's a smart function where it filters out views on the following parameters:
- A view obviously overlaps with it's parent view so that overlap should not be included.
- If view C overlaps with view B, but view A (a parent of view C) also overlaps with view B, then only the overlap between view A and view B is recorded.
- Ignores overlaps from views that are sent into the whiteList parameter.

There is another extension with the same functionality that works on **UIView** in case you want to check overlaps within a certain view.

## Capturing Text Truncation
Sometimes our labels don't lay out the way we want, especially on a smaller screen size or when accessibility is enabled.

We can use our extension on **UILabel**:
```swift
func isTruncated() -> Bool
```
## Capturing Out of Bounds Views
When auto layout or our frame logic doesn't behave the way we expect it to, our views sometimes won't be positioned properly.

We can use our extensions on **UIViewController**:
```swift
public func viewsOffScreen() -> [UIView]
public func viewsPartiallyOffScreen() -> [UIView]
public func viewsEntirelyOffScreen() -> [UIView]
```
Example:
```swift
context("When the view controller has finished laying out") {
  it("should have no views that are out of bounds") {
    expect(subject.viewsOffScreen()).to(beEmpty())
  }
}
```
There is another extension with the same functionality that works on **UIView** in case you want to check for out of bounds subviews within a certain view.

## Simulating User Action
We have some extensions that simulate how a user interacts with an iOS application.

Extension on **UITextField** to type in a String character by character:
```swift
func type(with text: String)
```
Example:
```swift
context("When the user types '1a2b3c' into a text field that only accepts numbers") {
  beforeEach {
    subject.numericTextField.type(with: "1a2b3c")
  }
  
  it("should have text: '123'") {
    expect(subject.numericTextField.text).to(be("123"))
  }
}
```


Extension on **UITextField** to paste in a String:
```swift
func paste(with text: String)
```
Example:
```swift
context("When the user pastes '1a2b3c' and then '12345' into a text field that only accepts numbers") {
  beforeEach {
    subject.numericTextField.paste(with: "1a2b3c")
    subject.numericTextField.paste(with: "12345")
  }
  
  it("should have text: '12345'") {
    expect(subject.numericTextField.text).to(be("12345"))
  }
}
```

Extension on **UIControl** that simulates a tap:
```swift
func tap()
```
Works on **UIButton**, **UITableViewCell** and more!
