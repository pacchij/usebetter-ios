// swiftlint:disable all
import Amplify
import Foundation

public struct UBUser: Model {
  public let id: String
  public var userId: String
  public var email: String
  public var displayName: String?
  public var firstName: String?
  public var lastName: String?
  public var fcmToken: String?
  public var apnsToken: String?
  public var friends: List<UBFriends>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      userId: String,
      email: String,
      displayName: String? = nil,
      firstName: String? = nil,
      lastName: String? = nil,
      fcmToken: String? = nil,
      apnsToken: String? = nil,
      friends: List<UBFriends>? = []) {
    self.init(id: id,
      userId: userId,
      email: email,
      displayName: displayName,
      firstName: firstName,
      lastName: lastName,
      fcmToken: fcmToken,
      apnsToken: apnsToken,
      friends: friends,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      userId: String,
      email: String,
      displayName: String? = nil,
      firstName: String? = nil,
      lastName: String? = nil,
      fcmToken: String? = nil,
      apnsToken: String? = nil,
      friends: List<UBFriends>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.userId = userId
      self.email = email
      self.displayName = displayName
      self.firstName = firstName
      self.lastName = lastName
      self.fcmToken = fcmToken
      self.apnsToken = apnsToken
      self.friends = friends
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}