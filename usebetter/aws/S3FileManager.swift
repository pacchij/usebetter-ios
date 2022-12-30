//
//  S3FileManager.swift
//  usebetter
//
//  Created by Prashanth Jaligama on 5/28/22.
//

import Foundation
import Combine

import Amplify
import AWSS3

class S3FileManager {
    private var bag = Set<AnyCancellable>()
    
    func downloadRemote(key: String, localURL: URL, completion: @escaping (Bool)->Void) {
        let storageOpertion = Amplify.Storage.downloadFile(key: key, local: localURL)
        let _ = storageOpertion.inProcessPublisher.sink { progress in
            logger.log("S3FileManager: readRemote: Progress: \(progress)")
        }
        .store(in: &bag)
        
        let _ = storageOpertion.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                logger.log("S3FileManager: readRemote: Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                completion(false)
            }
        }
        receiveValue: { data in
//            logger.log("S3FileManager: readRemote: Completed:")
//            Amplify.Storage.getURL(key: key)
//                .resultPublisher
//                .sink { data in
//                    logger.log("S3FileManager: readRemote: getURL: sink:")
//                }
//        receiveValue: { data in
//                    logger.log("S3FileManager: readRemote: getURL: reeciveValue: \(data)")
//                }
//        .store(in: &self.bag)
                
            
            
            completion(true)
        }
        .store(in: &bag)
    }
    
    func updateRemote(key: String, localURL: URL, completion: @escaping (Bool)->Void) {
        let storageOperation = Amplify.Storage.uploadFile(key:key, local: localURL)
        let _ = storageOperation.inProcessPublisher.sink { progress in
            logger.log("S3FileManager: updateRemote: Progress: \(progress)")
        }
        .store(in: &bag)
        
        let _ = storageOperation.resultPublisher.sink {
            if case let .failure(storageError) = $0 {
                logger.log("S3FileManager: updateRemote: Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
                completion(false)
            }
        }
        receiveValue: { data in
            logger.log("S3FileManager: updateRemote: Upload Completed: \(data)")
            completion(true)
        }
        .store(in: &bag)
    }
    
    func listUserFolders(completion: @escaping (StorageListResult)->Void) {
        Task {
            do {
                let result = try await Amplify.Storage.list()
                completion(result)
            }
            catch {
                logger.log("S3FileManager: listUserFolders: exception")
            }
        }
//            .resultPublisher
//            .sink {
//                if case let .failure(storageError) = $0 {
//                    logger.log("listUserFolders: Failed: \(storageError.errorDescription). \(storageError.recoverySuggestion)")
//                }
//            }
//            receiveValue: { listResult in
//                logger.log("listUserFolders: Completed")
//                completion(listResult)
//            }
//            .store(in: &bag)
    }
}
