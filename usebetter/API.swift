//  This file was automatically generated and should not be edited.

import AWSAppSync

public struct CreateTransactionsInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID? = nil, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int) {
    graphQLMap = ["id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state]
  }

  public var id: GraphQLID? {
    get {
      return graphQLMap["id"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var itemid: GraphQLID {
    get {
      return graphQLMap["itemid"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "itemid")
    }
  }

  public var ownerid: String {
    get {
      return graphQLMap["ownerid"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ownerid")
    }
  }

  public var receiverid: String {
    get {
      return graphQLMap["receiverid"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "receiverid")
    }
  }

  public var state: Int {
    get {
      return graphQLMap["state"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }
}

public struct ModelTransactionsConditionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(itemid: ModelIDInput? = nil, ownerid: ModelStringInput? = nil, receiverid: ModelStringInput? = nil, and: [ModelTransactionsConditionInput?]? = nil, or: [ModelTransactionsConditionInput?]? = nil, not: ModelTransactionsConditionInput? = nil) {
    graphQLMap = ["itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "and": and, "or": or, "not": not]
  }

  public var itemid: ModelIDInput? {
    get {
      return graphQLMap["itemid"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "itemid")
    }
  }

  public var ownerid: ModelStringInput? {
    get {
      return graphQLMap["ownerid"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ownerid")
    }
  }

  public var receiverid: ModelStringInput? {
    get {
      return graphQLMap["receiverid"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "receiverid")
    }
  }

  public var and: [ModelTransactionsConditionInput?]? {
    get {
      return graphQLMap["and"] as! [ModelTransactionsConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelTransactionsConditionInput?]? {
    get {
      return graphQLMap["or"] as! [ModelTransactionsConditionInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelTransactionsConditionInput? {
    get {
      return graphQLMap["not"] as! ModelTransactionsConditionInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct ModelIDInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: GraphQLID? = nil, eq: GraphQLID? = nil, le: GraphQLID? = nil, lt: GraphQLID? = nil, ge: GraphQLID? = nil, gt: GraphQLID? = nil, contains: GraphQLID? = nil, notContains: GraphQLID? = nil, between: [GraphQLID?]? = nil, beginsWith: GraphQLID? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil, size: ModelSizeInput? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "attributeExists": attributeExists, "attributeType": attributeType, "size": size]
  }

  public var ne: GraphQLID? {
    get {
      return graphQLMap["ne"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: GraphQLID? {
    get {
      return graphQLMap["eq"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: GraphQLID? {
    get {
      return graphQLMap["le"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: GraphQLID? {
    get {
      return graphQLMap["lt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: GraphQLID? {
    get {
      return graphQLMap["ge"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: GraphQLID? {
    get {
      return graphQLMap["gt"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: GraphQLID? {
    get {
      return graphQLMap["contains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: GraphQLID? {
    get {
      return graphQLMap["notContains"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [GraphQLID?]? {
    get {
      return graphQLMap["between"] as! [GraphQLID?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: GraphQLID? {
    get {
      return graphQLMap["beginsWith"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var attributeExists: Bool? {
    get {
      return graphQLMap["attributeExists"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeExists")
    }
  }

  public var attributeType: ModelAttributeTypes? {
    get {
      return graphQLMap["attributeType"] as! ModelAttributeTypes?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeType")
    }
  }

  public var size: ModelSizeInput? {
    get {
      return graphQLMap["size"] as! ModelSizeInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
    }
  }
}

public enum ModelAttributeTypes: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  public typealias RawValue = String
  case binary
  case binarySet
  case bool
  case list
  case map
  case number
  case numberSet
  case string
  case stringSet
  case null
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "binary": self = .binary
      case "binarySet": self = .binarySet
      case "bool": self = .bool
      case "list": self = .list
      case "map": self = .map
      case "number": self = .number
      case "numberSet": self = .numberSet
      case "string": self = .string
      case "stringSet": self = .stringSet
      case "_null": self = .null
      default: self = .unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .binary: return "binary"
      case .binarySet: return "binarySet"
      case .bool: return "bool"
      case .list: return "list"
      case .map: return "map"
      case .number: return "number"
      case .numberSet: return "numberSet"
      case .string: return "string"
      case .stringSet: return "stringSet"
      case .null: return "_null"
      case .unknown(let value): return value
    }
  }

  public static func == (lhs: ModelAttributeTypes, rhs: ModelAttributeTypes) -> Bool {
    switch (lhs, rhs) {
      case (.binary, .binary): return true
      case (.binarySet, .binarySet): return true
      case (.bool, .bool): return true
      case (.list, .list): return true
      case (.map, .map): return true
      case (.number, .number): return true
      case (.numberSet, .numberSet): return true
      case (.string, .string): return true
      case (.stringSet, .stringSet): return true
      case (.null, .null): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public struct ModelSizeInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: Int? = nil, eq: Int? = nil, le: Int? = nil, lt: Int? = nil, ge: Int? = nil, gt: Int? = nil, between: [Int?]? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "between": between]
  }

  public var ne: Int? {
    get {
      return graphQLMap["ne"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: Int? {
    get {
      return graphQLMap["eq"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: Int? {
    get {
      return graphQLMap["le"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: Int? {
    get {
      return graphQLMap["lt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: Int? {
    get {
      return graphQLMap["ge"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: Int? {
    get {
      return graphQLMap["gt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var between: [Int?]? {
    get {
      return graphQLMap["between"] as! [Int?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }
}

public struct ModelStringInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: String? = nil, eq: String? = nil, le: String? = nil, lt: String? = nil, ge: String? = nil, gt: String? = nil, contains: String? = nil, notContains: String? = nil, between: [String?]? = nil, beginsWith: String? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil, size: ModelSizeInput? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "contains": contains, "notContains": notContains, "between": between, "beginsWith": beginsWith, "attributeExists": attributeExists, "attributeType": attributeType, "size": size]
  }

  public var ne: String? {
    get {
      return graphQLMap["ne"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: String? {
    get {
      return graphQLMap["eq"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: String? {
    get {
      return graphQLMap["le"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: String? {
    get {
      return graphQLMap["lt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: String? {
    get {
      return graphQLMap["ge"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: String? {
    get {
      return graphQLMap["gt"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var contains: String? {
    get {
      return graphQLMap["contains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  public var notContains: String? {
    get {
      return graphQLMap["notContains"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
    }
  }

  public var between: [String?]? {
    get {
      return graphQLMap["between"] as! [String?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var beginsWith: String? {
    get {
      return graphQLMap["beginsWith"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  public var attributeExists: Bool? {
    get {
      return graphQLMap["attributeExists"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeExists")
    }
  }

  public var attributeType: ModelAttributeTypes? {
    get {
      return graphQLMap["attributeType"] as! ModelAttributeTypes?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeType")
    }
  }

  public var size: ModelSizeInput? {
    get {
      return graphQLMap["size"] as! ModelSizeInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
    }
  }
}

public struct UpdateTransactionsInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID, itemid: GraphQLID? = nil, ownerid: String? = nil, receiverid: String? = nil, state: Int) {
    graphQLMap = ["id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var itemid: GraphQLID? {
    get {
      return graphQLMap["itemid"] as! GraphQLID?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "itemid")
    }
  }

  public var ownerid: String? {
    get {
      return graphQLMap["ownerid"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ownerid")
    }
  }

  public var receiverid: String? {
    get {
      return graphQLMap["receiverid"] as! String?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "receiverid")
    }
  }

  public var state: Int {
    get {
      return graphQLMap["state"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }
}

public struct DeleteTransactionsInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: GraphQLID, state: Int) {
    graphQLMap = ["id": id, "state": state]
  }

  public var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var state: Int {
    get {
      return graphQLMap["state"] as! Int
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }
}

public struct ModelIntKeyConditionInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(eq: Int? = nil, le: Int? = nil, lt: Int? = nil, ge: Int? = nil, gt: Int? = nil, between: [Int?]? = nil) {
    graphQLMap = ["eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "between": between]
  }

  public var eq: Int? {
    get {
      return graphQLMap["eq"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: Int? {
    get {
      return graphQLMap["le"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: Int? {
    get {
      return graphQLMap["lt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: Int? {
    get {
      return graphQLMap["ge"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: Int? {
    get {
      return graphQLMap["gt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var between: [Int?]? {
    get {
      return graphQLMap["between"] as! [Int?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }
}

public struct ModelTransactionsFilterInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: ModelIDInput? = nil, itemid: ModelIDInput? = nil, ownerid: ModelStringInput? = nil, receiverid: ModelStringInput? = nil, state: ModelIntInput? = nil, and: [ModelTransactionsFilterInput?]? = nil, or: [ModelTransactionsFilterInput?]? = nil, not: ModelTransactionsFilterInput? = nil) {
    graphQLMap = ["id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "and": and, "or": or, "not": not]
  }

  public var id: ModelIDInput? {
    get {
      return graphQLMap["id"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var itemid: ModelIDInput? {
    get {
      return graphQLMap["itemid"] as! ModelIDInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "itemid")
    }
  }

  public var ownerid: ModelStringInput? {
    get {
      return graphQLMap["ownerid"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ownerid")
    }
  }

  public var receiverid: ModelStringInput? {
    get {
      return graphQLMap["receiverid"] as! ModelStringInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "receiverid")
    }
  }

  public var state: ModelIntInput? {
    get {
      return graphQLMap["state"] as! ModelIntInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }

  public var and: [ModelTransactionsFilterInput?]? {
    get {
      return graphQLMap["and"] as! [ModelTransactionsFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  public var or: [ModelTransactionsFilterInput?]? {
    get {
      return graphQLMap["or"] as! [ModelTransactionsFilterInput?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  public var not: ModelTransactionsFilterInput? {
    get {
      return graphQLMap["not"] as! ModelTransactionsFilterInput?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

public struct ModelIntInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(ne: Int? = nil, eq: Int? = nil, le: Int? = nil, lt: Int? = nil, ge: Int? = nil, gt: Int? = nil, between: [Int?]? = nil, attributeExists: Bool? = nil, attributeType: ModelAttributeTypes? = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "le": le, "lt": lt, "ge": ge, "gt": gt, "between": between, "attributeExists": attributeExists, "attributeType": attributeType]
  }

  public var ne: Int? {
    get {
      return graphQLMap["ne"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  public var eq: Int? {
    get {
      return graphQLMap["eq"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  public var le: Int? {
    get {
      return graphQLMap["le"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  public var lt: Int? {
    get {
      return graphQLMap["lt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  public var ge: Int? {
    get {
      return graphQLMap["ge"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  public var gt: Int? {
    get {
      return graphQLMap["gt"] as! Int?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  public var between: [Int?]? {
    get {
      return graphQLMap["between"] as! [Int?]?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  public var attributeExists: Bool? {
    get {
      return graphQLMap["attributeExists"] as! Bool?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeExists")
    }
  }

  public var attributeType: ModelAttributeTypes? {
    get {
      return graphQLMap["attributeType"] as! ModelAttributeTypes?
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "attributeType")
    }
  }
}

public enum ModelSortDirection: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  public typealias RawValue = String
  case asc
  case desc
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ASC": self = .asc
      case "DESC": self = .desc
      default: self = .unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .asc: return "ASC"
      case .desc: return "DESC"
      case .unknown(let value): return value
    }
  }

  public static func == (lhs: ModelSortDirection, rhs: ModelSortDirection) -> Bool {
    switch (lhs, rhs) {
      case (.asc, .asc): return true
      case (.desc, .desc): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class CreateTransactionsMutation: GraphQLMutation {
  public static let operationString =
    "mutation CreateTransactions($input: CreateTransactionsInput!, $condition: ModelTransactionsConditionInput) {\n  createTransactions(input: $input, condition: $condition) {\n    __typename\n    id\n    itemid\n    ownerid\n    receiverid\n    state\n    createdAt\n    updatedAt\n  }\n}"

  public var input: CreateTransactionsInput
  public var condition: ModelTransactionsConditionInput?

  public init(input: CreateTransactionsInput, condition: ModelTransactionsConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createTransactions", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(CreateTransaction.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(createTransactions: CreateTransaction? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "createTransactions": createTransactions.flatMap { $0.snapshot }])
    }

    public var createTransactions: CreateTransaction? {
      get {
        return (snapshot["createTransactions"] as? Snapshot).flatMap { CreateTransaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "createTransactions")
      }
    }

    public struct CreateTransaction: GraphQLSelectionSet {
      public static let possibleTypes = ["Transactions"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
        GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var itemid: GraphQLID {
        get {
          return snapshot["itemid"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "itemid")
        }
      }

      public var ownerid: String {
        get {
          return snapshot["ownerid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "ownerid")
        }
      }

      public var receiverid: String {
        get {
          return snapshot["receiverid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "receiverid")
        }
      }

      public var state: Int {
        get {
          return snapshot["state"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class UpdateTransactionsMutation: GraphQLMutation {
  public static let operationString =
    "mutation UpdateTransactions($input: UpdateTransactionsInput!, $condition: ModelTransactionsConditionInput) {\n  updateTransactions(input: $input, condition: $condition) {\n    __typename\n    id\n    itemid\n    ownerid\n    receiverid\n    state\n    createdAt\n    updatedAt\n  }\n}"

  public var input: UpdateTransactionsInput
  public var condition: ModelTransactionsConditionInput?

  public init(input: UpdateTransactionsInput, condition: ModelTransactionsConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateTransactions", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(UpdateTransaction.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(updateTransactions: UpdateTransaction? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "updateTransactions": updateTransactions.flatMap { $0.snapshot }])
    }

    public var updateTransactions: UpdateTransaction? {
      get {
        return (snapshot["updateTransactions"] as? Snapshot).flatMap { UpdateTransaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "updateTransactions")
      }
    }

    public struct UpdateTransaction: GraphQLSelectionSet {
      public static let possibleTypes = ["Transactions"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
        GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var itemid: GraphQLID {
        get {
          return snapshot["itemid"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "itemid")
        }
      }

      public var ownerid: String {
        get {
          return snapshot["ownerid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "ownerid")
        }
      }

      public var receiverid: String {
        get {
          return snapshot["receiverid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "receiverid")
        }
      }

      public var state: Int {
        get {
          return snapshot["state"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class DeleteTransactionsMutation: GraphQLMutation {
  public static let operationString =
    "mutation DeleteTransactions($input: DeleteTransactionsInput!, $condition: ModelTransactionsConditionInput) {\n  deleteTransactions(input: $input, condition: $condition) {\n    __typename\n    id\n    itemid\n    ownerid\n    receiverid\n    state\n    createdAt\n    updatedAt\n  }\n}"

  public var input: DeleteTransactionsInput
  public var condition: ModelTransactionsConditionInput?

  public init(input: DeleteTransactionsInput, condition: ModelTransactionsConditionInput? = nil) {
    self.input = input
    self.condition = condition
  }

  public var variables: GraphQLMap? {
    return ["input": input, "condition": condition]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteTransactions", arguments: ["input": GraphQLVariable("input"), "condition": GraphQLVariable("condition")], type: .object(DeleteTransaction.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(deleteTransactions: DeleteTransaction? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deleteTransactions": deleteTransactions.flatMap { $0.snapshot }])
    }

    public var deleteTransactions: DeleteTransaction? {
      get {
        return (snapshot["deleteTransactions"] as? Snapshot).flatMap { DeleteTransaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deleteTransactions")
      }
    }

    public struct DeleteTransaction: GraphQLSelectionSet {
      public static let possibleTypes = ["Transactions"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
        GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var itemid: GraphQLID {
        get {
          return snapshot["itemid"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "itemid")
        }
      }

      public var ownerid: String {
        get {
          return snapshot["ownerid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "ownerid")
        }
      }

      public var receiverid: String {
        get {
          return snapshot["receiverid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "receiverid")
        }
      }

      public var state: Int {
        get {
          return snapshot["state"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class GetTransactionsQuery: GraphQLQuery {
  public static let operationString =
    "query GetTransactions($id: ID!, $state: Int!) {\n  getTransactions(id: $id, state: $state) {\n    __typename\n    id\n    itemid\n    ownerid\n    receiverid\n    state\n    createdAt\n    updatedAt\n  }\n}"

  public var id: GraphQLID
  public var state: Int

  public init(id: GraphQLID, state: Int) {
    self.id = id
    self.state = state
  }

  public var variables: GraphQLMap? {
    return ["id": id, "state": state]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getTransactions", arguments: ["id": GraphQLVariable("id"), "state": GraphQLVariable("state")], type: .object(GetTransaction.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(getTransactions: GetTransaction? = nil) {
      self.init(snapshot: ["__typename": "Query", "getTransactions": getTransactions.flatMap { $0.snapshot }])
    }

    public var getTransactions: GetTransaction? {
      get {
        return (snapshot["getTransactions"] as? Snapshot).flatMap { GetTransaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getTransactions")
      }
    }

    public struct GetTransaction: GraphQLSelectionSet {
      public static let possibleTypes = ["Transactions"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
        GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var itemid: GraphQLID {
        get {
          return snapshot["itemid"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "itemid")
        }
      }

      public var ownerid: String {
        get {
          return snapshot["ownerid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "ownerid")
        }
      }

      public var receiverid: String {
        get {
          return snapshot["receiverid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "receiverid")
        }
      }

      public var state: Int {
        get {
          return snapshot["state"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class ListTransactionsQuery: GraphQLQuery {
  public static let operationString =
    "query ListTransactions($id: ID, $state: ModelIntKeyConditionInput, $filter: ModelTransactionsFilterInput, $limit: Int, $nextToken: String, $sortDirection: ModelSortDirection) {\n  listTransactions(id: $id, state: $state, filter: $filter, limit: $limit, nextToken: $nextToken, sortDirection: $sortDirection) {\n    __typename\n    items {\n      __typename\n      id\n      itemid\n      ownerid\n      receiverid\n      state\n      createdAt\n      updatedAt\n    }\n    nextToken\n  }\n}"

  public var id: GraphQLID?
  public var state: ModelIntKeyConditionInput?
  public var filter: ModelTransactionsFilterInput?
  public var limit: Int?
  public var nextToken: String?
  public var sortDirection: ModelSortDirection?

  public init(id: GraphQLID? = nil, state: ModelIntKeyConditionInput? = nil, filter: ModelTransactionsFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil, sortDirection: ModelSortDirection? = nil) {
    self.id = id
    self.state = state
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
    self.sortDirection = sortDirection
  }

  public var variables: GraphQLMap? {
    return ["id": id, "state": state, "filter": filter, "limit": limit, "nextToken": nextToken, "sortDirection": sortDirection]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("listTransactions", arguments: ["id": GraphQLVariable("id"), "state": GraphQLVariable("state"), "filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken"), "sortDirection": GraphQLVariable("sortDirection")], type: .object(ListTransaction.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(listTransactions: ListTransaction? = nil) {
      self.init(snapshot: ["__typename": "Query", "listTransactions": listTransactions.flatMap { $0.snapshot }])
    }

    public var listTransactions: ListTransaction? {
      get {
        return (snapshot["listTransactions"] as? Snapshot).flatMap { ListTransaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "listTransactions")
      }
    }

    public struct ListTransaction: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelTransactionsConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelTransactionsConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Transactions"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
          GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
          GraphQLField("state", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var itemid: GraphQLID {
          get {
            return snapshot["itemid"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "itemid")
          }
        }

        public var ownerid: String {
          get {
            return snapshot["ownerid"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "ownerid")
          }
        }

        public var receiverid: String {
          get {
            return snapshot["receiverid"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "receiverid")
          }
        }

        public var state: Int {
          get {
            return snapshot["state"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "state")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class TransactionsByOwnerQuery: GraphQLQuery {
  public static let operationString =
    "query TransactionsByOwner($ownerid: String!, $sortDirection: ModelSortDirection, $filter: ModelTransactionsFilterInput, $limit: Int, $nextToken: String) {\n  transactionsByOwner(ownerid: $ownerid, sortDirection: $sortDirection, filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      itemid\n      ownerid\n      receiverid\n      state\n      createdAt\n      updatedAt\n    }\n    nextToken\n  }\n}"

  public var ownerid: String
  public var sortDirection: ModelSortDirection?
  public var filter: ModelTransactionsFilterInput?
  public var limit: Int?
  public var nextToken: String?

  public init(ownerid: String, sortDirection: ModelSortDirection? = nil, filter: ModelTransactionsFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.ownerid = ownerid
    self.sortDirection = sortDirection
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["ownerid": ownerid, "sortDirection": sortDirection, "filter": filter, "limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("transactionsByOwner", arguments: ["ownerid": GraphQLVariable("ownerid"), "sortDirection": GraphQLVariable("sortDirection"), "filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(TransactionsByOwner.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(transactionsByOwner: TransactionsByOwner? = nil) {
      self.init(snapshot: ["__typename": "Query", "transactionsByOwner": transactionsByOwner.flatMap { $0.snapshot }])
    }

    public var transactionsByOwner: TransactionsByOwner? {
      get {
        return (snapshot["transactionsByOwner"] as? Snapshot).flatMap { TransactionsByOwner(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "transactionsByOwner")
      }
    }

    public struct TransactionsByOwner: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelTransactionsConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelTransactionsConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Transactions"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
          GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
          GraphQLField("state", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var itemid: GraphQLID {
          get {
            return snapshot["itemid"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "itemid")
          }
        }

        public var ownerid: String {
          get {
            return snapshot["ownerid"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "ownerid")
          }
        }

        public var receiverid: String {
          get {
            return snapshot["receiverid"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "receiverid")
          }
        }

        public var state: Int {
          get {
            return snapshot["state"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "state")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class TransactionsByReceiverQuery: GraphQLQuery {
  public static let operationString =
    "query TransactionsByReceiver($receiverid: String!, $sortDirection: ModelSortDirection, $filter: ModelTransactionsFilterInput, $limit: Int, $nextToken: String) {\n  transactionsByReceiver(receiverid: $receiverid, sortDirection: $sortDirection, filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      itemid\n      ownerid\n      receiverid\n      state\n      createdAt\n      updatedAt\n    }\n    nextToken\n  }\n}"

  public var receiverid: String
  public var sortDirection: ModelSortDirection?
  public var filter: ModelTransactionsFilterInput?
  public var limit: Int?
  public var nextToken: String?

  public init(receiverid: String, sortDirection: ModelSortDirection? = nil, filter: ModelTransactionsFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.receiverid = receiverid
    self.sortDirection = sortDirection
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  public var variables: GraphQLMap? {
    return ["receiverid": receiverid, "sortDirection": sortDirection, "filter": filter, "limit": limit, "nextToken": nextToken]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("transactionsByReceiver", arguments: ["receiverid": GraphQLVariable("receiverid"), "sortDirection": GraphQLVariable("sortDirection"), "filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .object(TransactionsByReceiver.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(transactionsByReceiver: TransactionsByReceiver? = nil) {
      self.init(snapshot: ["__typename": "Query", "transactionsByReceiver": transactionsByReceiver.flatMap { $0.snapshot }])
    }

    public var transactionsByReceiver: TransactionsByReceiver? {
      get {
        return (snapshot["transactionsByReceiver"] as? Snapshot).flatMap { TransactionsByReceiver(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "transactionsByReceiver")
      }
    }

    public struct TransactionsByReceiver: GraphQLSelectionSet {
      public static let possibleTypes = ["ModelTransactionsConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.object(Item.selections)))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(items: [Item?], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "ModelTransactionsConnection", "items": items.map { $0.flatMap { $0.snapshot } }, "nextToken": nextToken])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var items: [Item?] {
        get {
          return (snapshot["items"] as! [Snapshot?]).map { $0.flatMap { Item(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.map { $0.flatMap { $0.snapshot } }, forKey: "items")
        }
      }

      public var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["Transactions"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
          GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
          GraphQLField("state", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
          GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
          self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        public var itemid: GraphQLID {
          get {
            return snapshot["itemid"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "itemid")
          }
        }

        public var ownerid: String {
          get {
            return snapshot["ownerid"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "ownerid")
          }
        }

        public var receiverid: String {
          get {
            return snapshot["receiverid"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "receiverid")
          }
        }

        public var state: Int {
          get {
            return snapshot["state"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "state")
          }
        }

        public var createdAt: String {
          get {
            return snapshot["createdAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAt")
          }
        }

        public var updatedAt: String {
          get {
            return snapshot["updatedAt"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAt")
          }
        }
      }
    }
  }
}

public final class OnCreateTransactionsSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnCreateTransactions {\n  onCreateTransactions {\n    __typename\n    id\n    itemid\n    ownerid\n    receiverid\n    state\n    createdAt\n    updatedAt\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onCreateTransactions", type: .object(OnCreateTransaction.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onCreateTransactions: OnCreateTransaction? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onCreateTransactions": onCreateTransactions.flatMap { $0.snapshot }])
    }

    public var onCreateTransactions: OnCreateTransaction? {
      get {
        return (snapshot["onCreateTransactions"] as? Snapshot).flatMap { OnCreateTransaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onCreateTransactions")
      }
    }

    public struct OnCreateTransaction: GraphQLSelectionSet {
      public static let possibleTypes = ["Transactions"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
        GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var itemid: GraphQLID {
        get {
          return snapshot["itemid"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "itemid")
        }
      }

      public var ownerid: String {
        get {
          return snapshot["ownerid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "ownerid")
        }
      }

      public var receiverid: String {
        get {
          return snapshot["receiverid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "receiverid")
        }
      }

      public var state: Int {
        get {
          return snapshot["state"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnUpdateTransactionsSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnUpdateTransactions {\n  onUpdateTransactions {\n    __typename\n    id\n    itemid\n    ownerid\n    receiverid\n    state\n    createdAt\n    updatedAt\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onUpdateTransactions", type: .object(OnUpdateTransaction.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onUpdateTransactions: OnUpdateTransaction? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onUpdateTransactions": onUpdateTransactions.flatMap { $0.snapshot }])
    }

    public var onUpdateTransactions: OnUpdateTransaction? {
      get {
        return (snapshot["onUpdateTransactions"] as? Snapshot).flatMap { OnUpdateTransaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onUpdateTransactions")
      }
    }

    public struct OnUpdateTransaction: GraphQLSelectionSet {
      public static let possibleTypes = ["Transactions"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
        GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var itemid: GraphQLID {
        get {
          return snapshot["itemid"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "itemid")
        }
      }

      public var ownerid: String {
        get {
          return snapshot["ownerid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "ownerid")
        }
      }

      public var receiverid: String {
        get {
          return snapshot["receiverid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "receiverid")
        }
      }

      public var state: Int {
        get {
          return snapshot["state"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}

public final class OnDeleteTransactionsSubscription: GraphQLSubscription {
  public static let operationString =
    "subscription OnDeleteTransactions {\n  onDeleteTransactions {\n    __typename\n    id\n    itemid\n    ownerid\n    receiverid\n    state\n    createdAt\n    updatedAt\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("onDeleteTransactions", type: .object(OnDeleteTransaction.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(onDeleteTransactions: OnDeleteTransaction? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onDeleteTransactions": onDeleteTransactions.flatMap { $0.snapshot }])
    }

    public var onDeleteTransactions: OnDeleteTransaction? {
      get {
        return (snapshot["onDeleteTransactions"] as? Snapshot).flatMap { OnDeleteTransaction(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onDeleteTransactions")
      }
    }

    public struct OnDeleteTransaction: GraphQLSelectionSet {
      public static let possibleTypes = ["Transactions"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("itemid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ownerid", type: .nonNull(.scalar(String.self))),
        GraphQLField("receiverid", type: .nonNull(.scalar(String.self))),
        GraphQLField("state", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("updatedAt", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: GraphQLID, itemid: GraphQLID, ownerid: String, receiverid: String, state: Int, createdAt: String, updatedAt: String) {
        self.init(snapshot: ["__typename": "Transactions", "id": id, "itemid": itemid, "ownerid": ownerid, "receiverid": receiverid, "state": state, "createdAt": createdAt, "updatedAt": updatedAt])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      public var itemid: GraphQLID {
        get {
          return snapshot["itemid"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "itemid")
        }
      }

      public var ownerid: String {
        get {
          return snapshot["ownerid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "ownerid")
        }
      }

      public var receiverid: String {
        get {
          return snapshot["receiverid"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "receiverid")
        }
      }

      public var state: Int {
        get {
          return snapshot["state"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      public var createdAt: String {
        get {
          return snapshot["createdAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var updatedAt: String {
        get {
          return snapshot["updatedAt"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAt")
        }
      }
    }
  }
}