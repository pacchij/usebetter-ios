//
//  JSONInterpreter.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/28/22.
//

import Foundation


class JsonInterpreter {
    private let filePath: String
    
    init(filePath: String) {
        self.filePath = filePath
    }
    
    func read<T: Decodable>(type: T.Type) -> [T] {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(filePath)
            do {
                if !FileManager.default.fileExists(atPath: pathWithFilename.path) {
                    return []
                }
                
                logger.log("JsonInterpreter: read: file path \(pathWithFilename.path)")
                let jsonString = try String(contentsOfFile: pathWithFilename.path, encoding: String.Encoding.utf8)
                let dataString = Data(jsonString.utf8)
                
                let decoder = JSONDecoder()
                let model = try decoder.decode([T].self, from: dataString)
                return model
            } catch {
                logger.log("JsonInterpreter: read: Exception \(error)")
            }
        }
        return []
    }
    
//    func write(jsonString: String) -> Bool {
//        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            let pathWithFilename = documentDirectory.appendingPathComponent(filePath)
//            do {
//                logger.log("UserFeedModel: Writing to local file \(pathWithFilename.path)")
//                try jsonString.write(to: pathWithFilename,
//                                     atomically: true,
//                                     encoding: .utf8)
//                return true
//            } catch {
//                logger.log("JsonInterpreter: write: Exception \(error)")
//            }
//        }
//        return false
//    }
    
    func write<T: Encodable>(data: [T]) {
        do {
            let jsonData = try JSONEncoder().encode(data)
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                return
            }
            
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let pathWithFilename = documentDirectory.appendingPathComponent(filePath)
                
                logger.log("JsonInterpreter: write: file path \(pathWithFilename.path)")
                try jsonString.write(to: pathWithFilename, atomically: true, encoding: .utf8)
            }
        } catch {
            logger.log("JsonInterpreter: write: data Exception \(error)")
        }
    }
}
