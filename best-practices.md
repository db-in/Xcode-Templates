# iOS Best Practices

## Introduction

This document defines guidelines and best practices that should be followed by all developers of the team in order to ensure a cleaner code and more maitanable projects.

## Contents

1. [Assets](#assets)
1. [Coding](#coding)
1. [Templates](#templates)
1. [Localization](#localization)

## Assets

To take advantage of App Thining and ODR, all the assets are placed inside the [Assets catalogs][asset-catalogs].

For vector images, use the [vector graphics (PDFs)][vector-assets] into the asset catalogs, and have Xcode automatically generate the bitmaps from that.

    ├─ Assets.xcassets
	    ├─ Flags
	    ├─ Buttons
	    ├─ Colors
	    ├─ Backgrounds
	    	    ├─ bkgAssetName
	    	    

[vector-assets]: http://martiancraft.com/blog/2014/09/vector-images-xcode6/
[asset-catalogs]: https://developer.apple.com/library/ios/recipes/xcode_help-image_catalog-1.0/Recipe.html

## Coding

All the coding style and best practices are enforced by [Swift Guidelines][swift-guidelines] and [Apple Style][apple-guidelines].

[swift-guidelines]: https://swift.org/documentation/api-design-guidelines
[apple-guidelines]: https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/CodingConventions.html

### Scopes Declaration

* Brackets start at the same line and finishes at a new line.
* Use spaces before and after the return sign

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
func foo() -> Bool {
	// ...
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
func foo ()->Bool
{
	// ...
}
</pre>

### Colon & Semicolons

* Spaces before and after the Type declarations.
* Inside scope declarations use a space ONLY after the Type.

<pre style="background:#E6FFE5;border-color:#63D25C;border-left:6px #63D25C solid;">
class ClassA : NSObject {

	var foo: String
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
class ClassA: NSObject {
	
	var foo:String
}
</pre>

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
func fooGlobal() {
	// ...
}
	
class FooClass {
	func foo() {
		// ...
	}
	
	func test() {
		foo()
		
		Dispatch.main.async {
			self.foo()
		}
	}
}
</pre>

<pre style="background:#F9E2E4;border-color:#F6B7BE;border-left:6px #EF5138 solid;">
func foo() {
	// ...
}
	
class Foo {
	func foo() {
		// ...
	}
	
	func test() {
		foo()
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

	var emiratesID: String? {
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
	
	var emiratesID: String {
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

## Templates

![File Template](assets/file_template1.png)
![File Template](assets/file_template2.png)
![File Template](assets/file_template3.png)

The Emirates templates provides a starting point to enforce the Best Practices on this document. The Xcode templates are flexible enough to allow the creation of clusters/groups of files when needed. For example if a template for the interface requires a `.swift` + `.storyboard` file.

* All files follows the guides defined in the templates (explained in details at bellow);
* Templates defines various marks, which defines the ideal place in the files to insert chunks of code such as properties, protected functions, exposed functions, overriding functions, definitions, declarations, etc;
* The **Major marks** are defined with 96 characters, a dash before and after;
* The **Medium marks** are defined with 48 characters and a dash before;
* The **Minor marks** are defined with 24 characters (no dash);

In order to mantain a cleaner code, try to not exceed the limit of the **Major marks**, to avoid line breaks and long lines. This best practice comes from a community discussion over the most confortable way to work on the current screen monitors and eye studies about dynamic reading. It's the Swift adaptation of the widely known as 80 char limit.

<pre><code style="font-size:8px;">
// Imports at Top: import UIKit


// MARK: - Definitions -


// Global definitions:
1) NotificationName
2) CellName
3) typealias
4) etc


// MARK: - Type -


class Foo {


// MARK: - Properties


// All properties: 
1) private properties
2) fileprivate properties
3) internal properties (IBOutlet, includes overriden)
4) public properties (includes overriden)


// MARK: - Constructors


// Constructors 
1) convinience
2) designated
3) required


// MARK: - Overridden Methods


// Methods: 
1) internal (IBAction, class/static)
2) public (IBAction, class/static)
2) open (IBAction, class/static)


// MARK: - Protected Methods


// Methods: 
1) private
2) fileprivate
3) class/static


// MARK: - Exposed Methods


// Methods: 
1) internal (IBAction, class/static)
2) public (IBAction, class/static)
2) open (IBAction, class/static)

}
</code></pre>