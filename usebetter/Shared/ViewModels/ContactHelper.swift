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
                //let store = CNContactStore()
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
                DispatchQueue.main.async {
                    self.showSettingsAlert() { _ in}
                }
                completionHandler(true, nil)
                
            }
        case .restricted:
            DispatchQueue.main.async {
                self.showSettingsAlert() { _ in}
            }
            completionHandler(false,nil)
            
        default:
            completionHandler(false, nil)
        }
    }
    
    private func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
//        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Go to Settings to grant access.", preferredStyle: .alert)
//        if
//            let settings = URL(string: UIApplication.openSettingsURLString),
//            UIApplication.shared.canOpenURL(settings) {
//                alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
//                    completionHandler(false)
//                    UIApplication.shared.open(settings)
//                })
//        }
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
//            completionHandler(false)
//        })
//        present(alert, animated: true)
    }
}
