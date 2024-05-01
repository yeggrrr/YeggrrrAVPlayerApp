//
//  VideoInfo.swift
//  YeggrrrAVPlayerApp
//
//  Created by YJ on 5/1/24.
//

import Foundation

struct VideoInfo: Decodable {
    let id: String
    let title: String
    let thumbnailUrl: URL
    let duration: String
    let uploadTime: String
    let views: String
    let author: String
    let videoUrl: URL
    let description: String
    let subscriber: String
    let isLive: Bool
}
