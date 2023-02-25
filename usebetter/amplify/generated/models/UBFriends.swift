// swiftlint:disable all
import Amplify
import Foundation

public struct UBFriends: Model {
  public let id: String
  public var userId: String
  public var friendId: String
  public var groups: [String?]?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      userId: String,
      friendId: String,
      groups: [String?]? = nil) {
    self.init(id: id,
      userId: userId,
      friendId: friendId,
      groups: groups,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      userId: String,
      friendId: String,
      groups: [String?]? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.userId = userId
      self.friendId = friendId
      self.groups = groups
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}