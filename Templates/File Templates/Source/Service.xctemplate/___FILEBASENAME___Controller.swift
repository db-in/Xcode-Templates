/*
 *	___FILENAME___
 *	___PROJECTNAME___
 *
 *	Created by ___VARIABLE_authors___ on ___DATE___.
 *	Copyright ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
 */

import Foundation

// MARK: - Definitions -

protocol ___VARIABLE_productName___Service {
	func fetch(completed: @escaping NetworkFetchCompletionBlock<___VARIABLE_productName___Response>)
	func update(settings: [String: Bool], completed: @escaping NetworkFetchCompletionBlock<___VARIABLE_productName___Response>)
}

// MARK: - Type -

class ___FILEBASENAMEASIDENTIFIER___ : EKGNetworkAdapter, ___VARIABLE_productName___Service {

// MARK: - Properties

// MARK: - Protected Methods

	private func handle(result:EKGResult<___VARIABLE_productName___Response> ,completed: @escaping NetworkFetchCompletionBlock<___VARIABLE_productName___Response>) {
		DispatchQueue.main.async {
			switch result {
			case let .Success(settings):
				completed(.success(response: settings))
			case let .Failure(error):
				completed(.failure(code: error.string))
			}
		}
	}

// MARK: - Exposed Methods

	func fetch(completed: @escaping NetworkFetchCompletionBlock<___VARIABLE_productName___Response>) {

		let param = ___VARIABLE_productName___Params()

		fetch(JSONResource<___VARIABLE_productName___Response>(with: param)) { (result) in
			self.handle(result: result, completed: completed)
		}
	}

	func update(settings: [String: Bool], completed: @escaping NetworkFetchCompletionBlock<___VARIABLE_productName___Response>) {

		let param = ___VARIABLE_productName___Params()

		fetch(JSONResource<___VARIABLE_productName___Response>(with: param)) { (result) in
			self.handle(result: result, completed: completed)
		}
	}

// MARK: - Overridden Methods

}
