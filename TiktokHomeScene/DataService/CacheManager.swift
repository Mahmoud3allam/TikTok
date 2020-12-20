//
//  CacheManager.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 20/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
public enum Result<T> {
    case success(T)
    case failure(NSError)
}
class CacheManager {

    static let shared = CacheManager()

    private let fileManager = FileManager.default

    private lazy var mainDirectoryUrl: URL = {

        let documentsUrl = self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return documentsUrl
    }()
    func clearCache(){
        let fileManager = FileManager.default
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory( at: mainDirectoryUrl, includingPropertiesForKeys: nil, options: [])
            for file in directoryContents {
                do {
                    try fileManager.removeItem(at: file)
                }
                catch let error as NSError {
                    debugPrint("Ooops! Something went wrong: \(error)")
                }

            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    func getFileWith(stringUrl: String, completionHandler: @escaping (Result<URL>) -> Void ) {


        let file = directoryFor(stringUrl: stringUrl)

        //return file path if already exists in cache directory
        guard !fileManager.fileExists(atPath: file.path)  else {
            completionHandler(Result.success(file))
            return
        }

        DispatchQueue.global().async {
            guard let videoData = NSData(contentsOf: URL(string: stringUrl)!) else {
                completionHandler(Result.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            videoData.write(to: file, atomically: true)
            
            DispatchQueue.main.async {
                completionHandler(Result.success(file))
            }
        }
    }


    private func directoryFor(stringUrl: String) -> URL {

        let fileURL = URL(string: stringUrl)!.lastPathComponent

        let file = self.mainDirectoryUrl.appendingPathComponent(fileURL)

        return file
    }
    func isFileCashed(stringUrl: String, completionHandler: @escaping (Result<URL>) -> Void ) {
        let file = directoryFor(stringUrl: stringUrl)

        //return file path if already exists in cache directory
        guard !fileManager.fileExists(atPath: file.path)  else {
            completionHandler(Result.success(file))
            return
        }
        completionHandler(Result.failure(NSError(domain: "", code: 0, userInfo: nil)))
        
    }
    func cachFile(stringUrl: String, completionHandler: @escaping (Result<URL>) -> Void ) {


        let file = directoryFor(stringUrl: stringUrl)
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {return}
            guard let videoData = NSData(contentsOf: URL(string: stringUrl)!) else {
                completionHandler(Result.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            videoData.write(to: file, atomically: true)
            
            DispatchQueue.main.async {
                completionHandler(Result.success(file))
            }
        }
    }
    func getNumberOfCachedItems()->Int? {
        do {
        
         let directoryContents = try FileManager.default.contentsOfDirectory( at: mainDirectoryUrl, includingPropertiesForKeys: nil, options: [])
        return directoryContents.count
        }catch {
            return nil
        }
    }
}
