/*
 *  ___FILENAME___
 *  ___PROJECTNAME___
 *
 *  Created by ___FULLUSERNAME___ on ___DATE___.
 *  Copyright ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
 */

import UIKit

// MARK: - Definitions -

// MARK: - Type -

open class Assets {
    
// MARK: - Properties

// MARK: - Protected Methods

// MARK: - Exposed Methods
    
    open class func bundle() -> Bundle {

        let bundle = Bundle(for: self)
        return bundle
    }
    
    open class func image(named name: String) -> UIImage? {
    
        return UIImage(named: name, in: self.bundle(), compatibleWith: nil)
    }
    
    open class func viewController() -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: self.bundle())
        if let destVC = storyboard.instantiateInitialViewController() {
            return destVC
        }
        
        return nil
    }

// MARK: - Overridden Methods

}
