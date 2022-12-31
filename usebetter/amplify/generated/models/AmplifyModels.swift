// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "6ab4805ecf1aed546b7898e635c6816f"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: UBEvent.self)
  }
}