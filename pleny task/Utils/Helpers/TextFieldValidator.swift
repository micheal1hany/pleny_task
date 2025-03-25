//
//  TextFieldValidator.swift
//  pleny task
//
//  Created by Micheal Hany on 25/03/2025.
//

import Foundation


class TextFieldValidator{
    private init(){}
    
    enum FieldType{
        case requiredField
        case email
        case password
        case username
    }
    
    static func isFormValid(fieldsErrors:[String?])->Bool{
        return fieldsErrors.allSatisfy { $0 == nil }
    }
    
    
    static func validateEmptyValue(_ text: String?) -> String? {
        guard let text = text else {
            return nil
        }
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return "This field is required"
        }
        
        return nil
    }
    
    static func validateUserName(_ text: String?) -> String? {
        guard let text = text else {
            return nil
        }
       
        if text.count <= 3{
            return "Please enter valid username"
        }else{
            return validateEmptyValue(text)
        }
    }
    
    
}
