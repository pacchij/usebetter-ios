// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "b97a4c8fd68cbf551070eb0cb93531a0"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: UBEvent.self)
    ModelRegistry.register(modelType: UBUser.self)
    ModelRegistry.register(modelType: UBFriends.self)
  }
}