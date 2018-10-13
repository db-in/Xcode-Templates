# iOS Best Practices

## Introduction

This document defines guidelines and best practices that should be followed by all developers of the team in order to ensure a cleaner code and more maitanable projects.

## Contents

1. [Golden Rules](#golden_rules)
1. [Assets](#assets)
1. [Coding](#coding)
1. [Templates](#templates)
1. [Localization](#localization)

## Golden Rules

1. ***No recursive loop***. (*font*: [Sean Parent](https://channel9.msdn.com/Events/GoingNative/2013/Cpp-Seasoning))
1. ***ZERO accidental complication***. (*font*: [J. B. Rainsberger](https://www.youtube.com/watch?v=WSes_PexXcA))
	* **Dead Agile**: Aknoledge and accept that estimations can't go well with agile development, so we should not estimate first but instead evaluate later on. *#noestimation* (font: [Dave Thomas](https://www.youtube.com/watch?v=a-BOSpxYJ9M))
	* **Real Agile**: To get real estimations, TDD must be followed strictly (**think -> write test -> write just enough code -> refactor**).
1. ***Testing primary goal is Fast Feedback***, just by excercising tests you can get a quick feedback on how you can improve your code, every other reason (safety, maintenance, covarege, stability) is merely a side effect. [Diney Bomfim](https://medium.com/@dineybomfim/the-best-of-testing-is-the-timely-fast-feedback-d9514e9d4550)
1. ***Clarity, cohesion, coupling, complexity***. The original 2Cs (Coupling and Cohesion). Has been expanded to 3Cs, and can go up to 4Cs in Swift. (font: [Swift Guidelines](https://swift.org/documentation/api-design-guidelines/), [Istehad Chowdhurya and Mohammad Zulkernineb](https://www.sciencedirect.com/science/article/pii/S1383762110000615), [Greg Heo](https://www.skilled.io/u/swiftsummit/the-four-cs))

## Assets

1. **Use PDF with vector for icons**.
1. **Always use PNG for images** as per [Apple suggestion](https://developer.apple.com/library/archive/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/LoadingImages/LoadingImages.html#//apple_ref/doc/uid/TP40010156-CH17-SW9). If size is a concern, you can save a bit by using [TinyPNG](https://tinypng.com/), Photoshop or other kind of PNG optimizers and yet keep the lossless aspect, but never go through the JPG side of it for bundle assets. JPG are meant to downloadable images.
1. Define the naming basics for your assets. (font: [Xcode Assets naming](https://github.com/dkhamsing/ios-asset-names)).

## Coding

All the coding style and best practices are enforced by [Swift Guidelines][swift-guidelines] and [Apple Style][apple-guidelines].

[swift-guidelines]: https://swift.org/documentation/api-design-guidelines
[apple-guidelines]: https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/CodingConventions.html

### Closures/Blocks

* Whenever it has input parameters or more than one line of algorithm, the closure/block should have a declaration line
* If there is no parameters and it has only one line, we can use it inline

Swift:

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
array.sort { (item1, item2) in
	return item1 < item2
}

array.sort { $0 < $1 }

array.sort(<)

Dispatch.main.async { doSomething() }
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
array.sort { (item1, item2) in return item1 < item2 }

array.sort { var foo = item1; return foo < item2 }

Dispatch.main.async { doSomething(); doSomethingElse(); }
</pre>

### Proper Naming

* Include all the words needed to avoid ambiguity
* Striving for clarity at the point of use
* Prioritizing clarity over brevity
* Using CamelCase (not snake_case). Use reverseCamelCase for type declarations
* Omit needless words
* Use names based on roles, not types
* Prioritize US English words and grammar.
* Beginning factory methods with `make`
* Verb methods for mutating version and followed by -ed, -ing for the non-mutating version
* Boolean types should read like assertions (isEnabled)
* Protocols that describe what something is should read as nouns
* Protocols that describe a capability should end in -able or -ible
* Avoid abbreviations, unless it's a wide known acronym, as URL. Casing acronyms uniformly up or down (serverURL, urlForImage)
* Use the same base name to methods that share the same meaning
* Choose good parameter names that serve as documentation
* Labeling closure and tuple parameters

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
var cardHolderView: UIView?
var rolesTableView: UITableView?
private var roles: [(user: User, role: Role)]?

func makeUserRoles(for user: User, withOption: Option) -> [UserRole]

func centered() -> Self

mutating func center(at view: UIView)
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
@IBOutlet var viUser: UIView?
@IBOutlet var tbvRoles: UITableView?
private var _roles: [(User, Role)]?

func userRoles(forUser: User, with option: Option) -> [UserRole]

func center() -> Self

mutating func centering(at view: UIView)
</pre>

### Parameters Order

* Choose good parameter names that serve as documentation
* If it's necessary to break lines due to the line length, keep the consistency by break one parameter per line, instead of clustering them

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
func makeUserToken(for number: inout String,
                   username:String,
                   role:String = "Default",
                   completion: @escape (() -> Void),
                   options:String...) -> String {
		// ...
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
func foo(varA:String, varB:String = "Default",
         varC:()->Void, inout varD:String, variadic:String...) -> String {
		// ...
}
</pre>


### Ternary Conditional Operator

* Avoid combining multiple instances of ternary operators into one single statement

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
var foo = boolVar ? 1 : 2
foo = anotherBoolVar ? foo : 3
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
var foo = anotherBoolVar ? (boolVar ? 1 : 2) : 3
</pre>

### Self (where to use)

* Avoid writing `self` unnecessarily for any internal call
* You can make use of `self` wherever it becomes necessary, like in closures
* Avoid ambiguities with any global scope

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
func globalFoo() {
	// ...
}

class FooClass {

    var aProperty = ""
    
	func foo() {
		globalFoo()
	}

	func test() {
		Dispatch.main.async {
			self.foo()
		}
		
		return aProperty()
	}
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
func foo() {
	// ...
}

class Foo {

    var aProperty = ""

	func foo() {
		foo()
	}

	func test() -> String {
		return self.nonConflictingVar
	}
}
</pre>

### Switch Case

* Avoid brackets
* Try to group cases with the same algorithm
* Make use of the power of Pattern Matching whenever is possible
* Avoid parenthesis writing the switch input
* The `default` case can be omitted whenever the switch case is exaustive, which means covering all the possible cases.

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
switch variable {
	case .a:
		// ...
	case .b(let foo), .c(let foo):
		// ...
	case .d..<.g:
		// ...
	case .h where .h.foo == "":
		// ...
	default:
		// ...
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
switch (variable) {
	case .a: {
		// ...
	}
	case .b(let foo):
		fallthrough
	case .c(let foo):
		// ...
}
</pre>

### Optionals

* Optionals should be used smartely, only when it's context requires so
* Don't use optional for all API parameters just because the Server Side team says they can omit any parameter. The optinal rule is based on what the mobile app requires
* Whenever the parameter is not there and the mobile app requires it, a decision about the default value should be taken
* Avoid Implicitly Unwrapped values as much as possible. They are supposed to be used only for compiler fatal errors, like `IBOutlets`

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
class UserModel {
	var id: String?
	var username: String = ""
	var password: String = ""
	var phone: String?

	var composedID: String? {
		guard userID = id else {
			return nil
		}

		return "ek" + userID
	}

	func phoneNumber(isLocalized: Bool) -> String? {
		guard userPhone = phone else {
            return nil
        }

		return "971" + userPhone
	}
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
class UserModel {
	var id: String?
	var username: String?
	var password: String?
	var phone: String!

	var composedID: String {
		return "ek" + (userID ?? "")
	}

	func phoneNumber(isLocalized: Bool) -> String {
		return "971" + phone
	}
}
</pre>

### Guard Statement

* Don't use guard unless the function needs to return a value or throws an error
* Avoid using guard only for unwrapping `nil` , there are better ways to work with `nil`

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
func foo() {
	if let optionalBinding = someOptional {
	    // ...
	}
}

func fooReturning() throws -> String {
	guard condition else {
	    // return or throw
	}

	// Some other logic
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
func fooReturning() throws -> String {
	if let optionalBinding = someOptional {
	    // ...
	}

	return ""
}
</pre>

### Extensions

* Use swift extension as a powerful way to enforce a good Coupling and Cohesion
* Separate each protocol extension into a new extension
* Use extensions to group logical and related functionalities, behaviors and algorithms
* Whenever possible, try to enforce *Protocol Oriented Programming* using extensions to decouple and improve the code reusability
* For reusable extensions on Apple framework, use "+" to ecapsulate related functionalities

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
protocol Routable {
	var currentPoint: Point { get }
	func makeNewRoute(to: Point) -> Route
}

extension Routable {
	func makeNewRoute(from: Point, to: Point) -> Route {
		// ...
	}
}

class RouteViewController : UIViewController {
	// ...
}

extension RouteViewController : UITableViewDataSource {
	tableView(...)
}

extension RouteViewController : Routable {
	var currentPoint: Point {
		return Point()
	}
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
protocol Routable {
	var currentPoint: Point { get }
	func makeNewRoute(to: Point) -> Route
}

class RouteViewController : UIViewController, UITableViewDataSource, Routable {
	var currentPoint: Point {
		return Point()
	}

	func makeNewRoute(to: Point) -> Route {
		// ...
	}

	tableView(...)
}
</pre>

### File Size

* Each file should not have more than 500 lines following the syntax described in this document. Whenever this limit is exceeded a refactoring should be considered. Extracting components, removing tight coupled algorithms and separating responsibilities that might be overwhelming the file.

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
1. ...
20. class Foo() {
...
500.
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
1. ...
20. class Foo() {
...
920. }
...
2130.
</pre>

### Access Controls

* Accessors should be used to optimize the compilation time and also the runtime, using them properly can save a lot of processing
* Every API intended to be used as a framework should be defined as `public` or `open`
* Every API on the main app target (Interface Layer) can be defined as `internal`. Once this access control is the default, nothing should be explicity written in the syntax.
* For every API that is not used outside its own file, use `fileprivate`. It's important to properly place the fileprivates. A `fileprivate` placed inside an extension should not be intented to be used by the main type declaration.
* For every API that is not intend to be used outside its own scope, use `private` access
* Use `final` when there is no intent for subclassing. Often, using `final` for `ViewControllers` is a best practice if they are not meant to be overridden. Try to enforce it wherever possible due to its optimization. For functions, the `static` could also be used as an optimizer once its result is the same as `class` AND `final`.
* Whenever some private or fileprivate entity is required to proper Unit Test, the architecture of the entity should not be changed just for sake of testing. Instead, a Dependency Injection should be considered (preferably Initializer Injection with a default value pointing to the production value)

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
// --- Module Foo

public class A {

	private func fooToPrivateUse() {...}
	fileprivate func fooToFileUse() {...}
	func fooToInternalUse() {...}
	public func fooToGlobalUse() {...}
}

extension A {

	private func foo() {
		fooToFileUse()
	}
}

open class B {

	public final func fooNonOverridable() {...}
	public func fooToInternalOverriding() {...}
	open func fooToExternalOverriding() {...}
}

// --- Main App Target

class OrdinaryClass {

	private func fooToPrivateUse() {...}
	func fooToGlobalUse() {...}
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
// Module Foo

public class A {
	public func fooToInternalUse() {...}
	func foo() {
		fooToInternalUse()
	}
}

extension A {
	fileprivate func fooToFileUse() {...}
}

open class B {
	open func fooNotIntentToBeOverrided() {...}
}

// Main App Target

public class OrdinaryClass {
	public foo() {...}
}
</pre>

### Unit Tests

* No business logic should reside in views or view controllers. ViewModels or Logic Objects should be created to hold and contain all the logic. So they are not tied to any presentation layer and can be easily tested.
* Business-related code includes:
	* Business logic (i.e. story acceptance criteria)
	* Field/form validation
	* Helper functions
	* Tridion keys
	* Network parameter building and responses
	* Database query results
	* UI setup, fonts, colors, etc.
	* TableView and CollectionView DataSource and Delegate
	* View controller setup

* Unit tests should NOT cover:
	* Displayed local-language text

* For Mocking API responses, local JSONs or related files should be used. All the local JSONs should be embedded as Git Submodule or Subtree.
* For Mocking Singletons inside object, preferably expose then as dependency injection and make the production Singleton as the default, so the Unit Test can replaced it if needed.
* Naming:
	* It has to answer 3 questions: **What? How? Why?**
	* XCTest syntax: testUnitOfWork_StateUnderTest_ExpectedBehavior
	* Quick BDD syntax: Should always include the 3 levels:
```
describe("UnitOfWork") {
	context("StateUnderTest") {
		it("ExpectedBehavior") {
```
* Orient the test towards behaviors. If 1 method has 2 possible behaviors, create 2 tests then. If a chain of 4 methods has only 1 possible behaviors, write only 1 test. **IMPORTANT**: Behavior is not the same as result. The following function has 2 behaviors with N results:

```
func upperFoo(param: String?) -> String {
	guard let string = param else {
		return ""
	}

	return param.upperCased()
}
```
* Test Coverage: The coverage should focus on the business logic. The coverage must aim for more than 80% coverage on this part.

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">

extension MyServiceServerProtocol {
	func fetch() -> Response {
		let json = try! JSON(fromFile: "aMockFile.json")
		let response = try! Response(json: json)

		return .sucess(response: response)
	}
}

describe("Testing MyServiceLogic") {
	context("with a valid input") {
		it("should return one single object") {
			// expectations go here
		}
	}
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
describe("for every user") {
	it("has to pass") {
		// expectations go here
		let vc = storyboard.instantiateViewController(withIdentifier: "id") as! MyViewController
		_ = vc.view

		vc.someMethodAtVC()
	}
}
</pre>