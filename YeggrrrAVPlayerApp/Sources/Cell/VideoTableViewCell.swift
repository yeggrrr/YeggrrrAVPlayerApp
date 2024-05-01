//
//  VideoTableViewCell.swift
//  YeggrrrAVPlayerApp
//
//  Created by YJ on 5/1/24.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "VideoTableViewCell"
    
    // 썸네일
    func setThumbnail(imageURL: URL) {
        DispatchQueue.global().async { [ weak self ] in
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.thumbnailImage.image = image
                    }
            } else {
                DispatchQueue.main.async {
                    self?.thumbnailImage.image = UIImage(systemName: "video.fill")
                    self?.thumbnailImage.tintColor = .darkGray
                }
            }
        }
    }
    
    // 타이틀
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
}
