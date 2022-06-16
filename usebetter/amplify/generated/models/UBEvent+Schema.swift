// swiftlint:disable all
import Amplify
import Foundation

extension UBEvent {
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
    let uBEvent = UBEvent.keys
    
    model.authRules = [
      rule(allow: .private, operations: [.create, .update, .delete, .read]),
      rule(allow: .groups, groupClaim: "cognito:groups", groups: ["Admins"], provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
      model.syncPluralName = "UBEvents"
    
    model.attributes(
      .index(fields: ["id", "state"], name: nil),
      .index(fields: ["ownerid"], name: "byOwner"),
      .index(fields: ["receiverid"], name: "byReceiver")
    )
    
    model.fields(
      .id(),
      .field(uBEvent.itemid, is: .required, ofType: .string),
      .field(uBEvent.ownerid, is: .required, ofType: .string),
      .field(uBEvent.receiverid, is: .required, ofType: .string),
      .field(uBEvent.state, is: .required, ofType: .int),
      .field(uBEvent.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(uBEvent.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}
