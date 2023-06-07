//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___VARIABLE_authors___ on ___DATE___.
//

import Foundation

// MARK: - Definitions -

// MARK: - Type -

struct ___FILEBASENAMEASIDENTIFIER___ : EKGBuildable {

// MARK: - Properties

	var httpMethod: EKGHTTPMethod {
		return .GET
	}

	var path: String {
		return "___VARIABLE_serviceURL___"
	}

// MARK: - Protected Methods

// MARK: - Exposed Methods

	func paramsDictionary() -> [String : Any] {
		return [:]
	}

// MARK: - Overridden Methods

}
