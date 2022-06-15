// swiftlint:disable all
import Amplify
import Foundation

extension Transactions {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case itemid
    case ownerid
    case receiverid
    case state
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let transactions = Transactions.keys
    
    model.authRules = [
      rule(allow: .private, operations: [.create, .update, .delete, .read]),
      rule(allow: .groups, groupClaim: "cognito:groups", groups: ["Admins"], provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Transactions"
    
    model.attributes(
      .index(fields: ["id", "state"], name: nil),
      .index(fields: ["ownerid"], name: "byOwner"),
      .index(fields: ["receiverid"], name: "byReceiver")
    )
    
    model.fields(
      .id(),
      .field(transactions.itemid, is: .required, ofType: .string),
      .field(transactions.ownerid, is: .required, ofType: .string),
      .field(transactions.receiverid, is: .required, ofType: .string),
      .field(transactions.state, is: .required, ofType: .int),
      .field(transactions.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(transactions.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}