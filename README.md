# UnIt
> Oh my goodness, UnIt is just an absolute unit 🔥🔥🔥 - Anonymous

Unit tests are great for testing business logic and your models. However, it get's a little cumbersome when you are trying to test view specific logic due to boilerplate code, drilling through multiple view layers or UIKit laziness. This framework attempts to ease some of that pain away with helpful extensions on your favourite classes like **UIView**, **UIViewController** and more! By having your UI able to be easily validated by unit tests, we can capture visual bugs really early before we get shamed by our QA department :( 

## Installation
Will support Cocoapods, Carthage and Swift Package Manager in the near future!

## Removing UIViewController boilerplate code
When creating a view controller in unit tests, UIKit decides to be lazy and does the least possible work possible. In unit tests, the view lifecycle method - **viewDidLoad**, **viewWillAppear**, **viewDidAppear** are not guaranteed to be invoked. This results in developers doing stuff like getting the key window, attach the view controller to the key window and make it key and visible - blegh.

Instead we can use this extension on **UIViewController**:
```swift
func kickUIKit(for device:Device)
```
Example:
```swift
beforeEach {
  // Instantiate view controller with your custom instantiation code.
  viewController.kickUIKit(for: Device.iPhoneXS)
}
```
This function guarantees that the view controller's view lifecycle will run properly with the given iOS device size.

## Finding UI elements
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
return myView.firstView(ofType: MyCustomView.self, passing: { $0.titleLabel.text == "Toronto Maple Leafs" && $0.backgroundColor = UIColor.blue } )
```
The example above states that within **myView**, return the first subview that is a **MyCustomView** class with the titleLabel text of "Toronto Maple Leafs" and has a blue background color.

## Capturing constraints
Constraint breaks are one of the top 5 most unenjoyable experiences an iOS developer can experience. All we get is a system log of all the conflicting constraints that shames us and is hard to read.

We can use our extension on **UIViewController**
```swift
public var conflictingConstraints: [[NSLayoutConstraint]]
```
Example:
```swift
context("When the view controller has finished laying out") {
  it("should have no conflicting constraints") {
    expect(viewController.conflictingConstraints).to(beEmpty())
  }
}
```
It may not be easier to read, but we now can have our conflicting constraints captured by our unit tests / CI which makes this really neat.

**Note**: In order to capture constraints, we partake in the black magic of swizzling. Use this at your own risk. The private method could be changed or deprecated at any time by Apple.
