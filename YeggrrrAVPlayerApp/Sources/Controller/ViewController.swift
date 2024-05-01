//
//  ViewController.swift
//  YeggrrrAVPlayerApp
//
//  Created by YJ on 5/1/24.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    @IBOutlet weak var videoListTableView: UITableView!
    
    var videoInfoList: [VideoInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.videoListTableView.reloadData()
            }
        }
    }
    
    let urlString = "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json"
    override func viewDidLoad() {
        super.viewDidLoad()
        videoListTableView.dataSource = self
        videoListTableView.delegate = self
        getData()
        
    }
    
    func getData() {
        guard let url = URL(string: urlString) else { return }
        
        Task {
            do {
                let urlRequest = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(from: url)
                let videoInfoList = try JSONDecoder().decode([VideoInfo].self, from: data)
                self.videoInfoList = videoInfoList
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    // AVPlayerContoller 띄우기
    func presentAVPlayerViewController(videoURL: URL) {
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: videoURL as URL)
        
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}

extension ViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier, for: indexPath) as? VideoTableViewCell else { return UITableViewCell() }
        
        let product = self.videoInfoList[indexPath.row]
        cell.setThumbnail(imageURL: product.thumbnailUrl)
        cell.setTitle(title: product.title)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.videoInfoList[indexPath.row]
        presentAVPlayerViewController(videoURL: product.videoUrl)
    }
}



