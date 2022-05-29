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
    
    func read() -> [UBItemRemote] {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(filePath)
            do {
                if !FileManager.default.fileExists(atPath: pathWithFilename.path) {
                    return []
                }
                let jsonString = try String(contentsOfFile: pathWithFilename.path, encoding: String.Encoding.utf8)
                let dataString = Data(jsonString.utf8)
                
                let decoder = JSONDecoder()
                let model = try decoder.decode([UBItemRemote].self, from: dataString)
                return model
            } catch {
                print("JsonInterpreter: write: Exception \(error)")
            }
        }
        return []
    }
    
    func write(jsonString: String) -> Bool {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent(filePath)
            do {
                print("UserFeedModel: Writing to local file \(pathWithFilename.path)")
                try jsonString.write(to: pathWithFilename,
                                     atomically: true,
                                     encoding: .utf8)
                return true
            } catch {
                print("JsonInterpreter: write: Exception \(error)")
            }
        }
        return false
    }
    
    func write(data1: [UBItemRemote]) {
        do {
            let jsonData = try JSONEncoder().encode(data1)
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                return
            }
            
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let pathWithFilename = documentDirectory.appendingPathComponent(filePath)
                try jsonString.write(to: pathWithFilename, atomically: true, encoding: .utf8)
            }
        } catch {
            print("JsonInterpreter: write: data Exception \(error)")
        }
    }
}
