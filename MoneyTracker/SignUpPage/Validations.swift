//
//  Validations.swift
//  MoneyTracker
//
//  Created by Mac on 23/12/1944 Saka.
//

import Foundation
extension String {

    func isValidUserName() -> Bool {
        let userNameRegex = "^[a-zA-Z]+$"
          return NSPredicate(format: "SELF MATCHES %@", userNameRegex).evaluate(with: self)
       }
     func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[!@#$%^&+=])(?=.*[A-Za-z]).{8,}$"
         
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    func isValidEmail() -> Bool{
        let emailidRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

          return NSPredicate(format: "SELF MATCHES %@",emailidRegex).evaluate(with: self)
    }
    
    func isValidAmount() -> Bool{
        let amountRegex = "^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$"
        
        return NSPredicate(format: "SELF MATCHES %@", amountRegex).evaluate(with: self)
    }
    
 //   func isValidDate() -> Bool {
    //    let dateRegex = ""
        
    //    return NSPredicate(format: "SELF MATCHES %@", dateRegex).evaluate(with: self)
   // }
    
    func isValidCategoryAndSubCategory() -> Bool{
        let categoryRegex = ".*[^A-Za-z ].*"
        return NSPredicate(format: "SELF MATCHES %@", categoryRegex).evaluate(with: self)
    }
    
    
    
}
