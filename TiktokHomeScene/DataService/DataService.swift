//
//  DataService.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 16/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
class DataService {
    init() {
        self.cachVideos()
    }
    static let shared = DataService()
    private let exploreVideos : [Video] = [
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5c67b35650633.mp4", seenCount: 500, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5c6797ab1a640.mp4", seenCount: 100, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4",seenCount: 300, likesCount: 100,reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5c6797ab1a640.mp4", seenCount: 242, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5c66f3d85b5bb.mp4", seenCount: 1000, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5c667ae367b58.mp4", seenCount: 242, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5baed037dee0f.mp4", seenCount: 523, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5bde5a2496a8f.mp4", seenCount: 2422, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/59003d430b287.mp4", seenCount: 2342, likesCount: 100, reactionCount: 23),
    
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5951acead8ad4.mp4", seenCount: 2342, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5b3598862e608.mp4", seenCount: 2342, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/59a5f6a73a648.mp4", seenCount: 2342, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/58ce544fa59dd.mp4", seenCount: 2342, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://stream.livestreamfails.com/video/5b7923c066540.mp4", seenCount: 2342, likesCount: 100, reactionCount: 23),

    ]
    func getExploreVideos()->[Video] {
        return self.exploreVideos
    }
    func cachVideos() {
        CacheManager.shared.clearCache()
        self.exploreVideos.forEach { (video) in
            print(video.videoURL)
            CacheManager.shared.isFileCashed(stringUrl: video.videoURL) {[weak self] (isFileCashed) in
                guard let self = self else {return}
                switch isFileCashed {
                case .success(_):
                    print("Already Cached")
                case .failure(_):
                    CacheManager.shared.cachFile(stringUrl: video.videoURL) { [weak self] (result) in
                        guard self != nil else {return}
                        switch result {
                        case .success( _) :
                            print("Done caching \(video.videoURL)")
                        case .failure( _) :
                            print("Can't cach \(video.videoURL)")
                        }
                    }
                }
            }
        }
    }
}


struct Video {
    var videoName:String
    var videoURL:String
    var seenCount:Int
    var likesCount:Int
    var reactionCount:Int
}
