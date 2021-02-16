//
//  Validation.swift
//  Practice
//
//  Created by Cypress on 2/8/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

import Foundation

struct Validation {
    enum ValidationPattern: String {
        case emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case passwordPattern = "(?=[^a-z]*[a-z])[^0-9]*[0-9].*"
    }
    
    static func emailIsValid(_ text: String?) -> Bool {
        let isValid = validateString(text, pattern: ValidationPattern.emailPattern.rawValue)
        return isValid
    }
    
    static func passwordIsValid(_ text: String?) -> Bool {
        let isValid = validateString(text, pattern: ValidationPattern.passwordPattern.rawValue)
        return isValid
    }
    
    // MARK: Helpers
    
    private static func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    private static func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}
