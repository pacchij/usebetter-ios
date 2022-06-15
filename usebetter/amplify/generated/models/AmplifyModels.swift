// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "86c3ff7a51af436b173d8e225646b631"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: transactions.self)
  }
}