//
//  ContactHelper.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/30/22.
//

import Foundation
import Contacts

class ContactHelper {
    let store = CNContactStore()
    func fullName(for number: String, completionHandler: @escaping (Bool, String?) -> Void ) {
        
        hasAccess() { succeeded, value in
            guard succeeded && value == nil else {
                print("ContactHelper: fullName: did not find contact")
                completionHandler(false, nil)
                return
            }
        
        
            let phoneNumber = CNPhoneNumber(stringValue: number)
            let predicate = CNContact.predicateForContacts(matching: phoneNumber)

            let toFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
            
            do {

                let contacts = try self.store.unifiedContacts(matching: predicate, keysToFetch: toFetch)
                
                for contact in contacts {
                    let name = contact.givenName + " " + contact.middleName + " " + contact.familyName
                    completionHandler(true, name)
                    return
                }
            }
            catch {
                print("ContactHelper: fullName: Exception \(error)")
            }
            completionHandler(false, nil)
        }
    }
    
    private func hasAccess(completionHandler: @escaping (Bool, Error?) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler(true, nil)
        case .notDetermined:
            
            self.store.requestAccess(for: .contacts) { succeeded, error in
                guard error == nil && succeeded else {
                    completionHandler(true, error)
                    return
                }

                completionHandler(true, nil)
                
            }
        case .restricted:
            completionHandler(false,nil)
            
        default:
            completionHandler(false, nil)
        }
    }
    
    func contactFullname(for number: String, completionHandler: @escaping (String) -> Void) {
        let name = "Not found in your contact"
        fullName(for: number) { succeeded, value in
            guard succeeded && value != nil else {
                completionHandler(name)
                return
            }
            completionHandler(value ?? name)
        }
    }

}
