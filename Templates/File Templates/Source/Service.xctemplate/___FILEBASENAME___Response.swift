//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___VARIABLE_authors___ on ___DATE___.
//

 import Foundation

// MARK: - Definitions -

// MARK: - Type -

struct ___FILEBASENAMEASIDENTIFIER___ : ParsableResult {

// MARK: - Properties

	private(set) var paramA: String?

// MARK: - Constructors

	init() {
		// No code
	}

	init(jsonObject: JSON) throws {
		self.init(json: jsonObject)

		// Faillable conditions
	}

// MARK: - Protected Methods

// MARK: - Exposed Methods

	mutating func parsing(_ parser: Parser) {
		paramA <-> parser["paramAKey"]
	}

// MARK: - Overridden Methods

}
