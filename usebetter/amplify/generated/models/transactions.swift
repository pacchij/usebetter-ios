// swiftlint:disable all
import Amplify
import Foundation

public struct transactions: Model {
  public let id: String
  public var itemid: String
  public var ownerid: String
  public var receiverid: String
  public var state: Int
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      itemid: String,
      ownerid: String,
      receiverid: String,
      state: Int) {
    self.init(id: id,
      itemid: itemid,
      ownerid: ownerid,
      receiverid: receiverid,
      state: state,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      itemid: String,
      ownerid: String,
      receiverid: String,
      state: Int,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.itemid = itemid
      self.ownerid = ownerid
      self.receiverid = receiverid
      self.state = state
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}