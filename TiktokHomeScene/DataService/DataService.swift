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
    }
    static let shared = DataService()
    private let exploreVideos : [Video] = [
    Video(videoName: "Any Content", videoURL: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v", seenCount: 500, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", seenCount: 100, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4",seenCount: 300, likesCount: 100,reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4", seenCount: 242, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", seenCount: 1000, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4", seenCount: 242, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", seenCount: 523, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", seenCount: 2422, likesCount: 100, reactionCount: 23),
    Video(videoName: "Any Content", videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", seenCount: 2342, likesCount: 100, reactionCount: 23),
    ]
    func getExploreVideos()->[Video] {
        return self.exploreVideos
    }
}


struct Video {
    var videoName:String
    var videoURL:String
    var seenCount:Int
    var likesCount:Int
    var reactionCount:Int
}
