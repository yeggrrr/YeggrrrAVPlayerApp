//
//  ViewController.swift
//  YeggrrrAVPlayerApp
//
//  Created by YJ on 5/1/24.
//

import UIKit
import AVKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var videoListTableView: UITableView!
    
    let urlString = "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json"
    
    var videoInfoList: [VideoInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.videoListTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoListTableView.dataSource = self
        videoListTableView.delegate = self
        getData()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .darkGray
        view.tintColor = .darkGray
    }
    
    func getData() {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, request, error in
            guard let data = data else { return }
            
            do {
                let decorder = JSONDecoder()
                let result = try decorder.decode([VideoInfo].self, from: data)
                print(result)
                self.videoInfoList = result
            } catch {
                print("error:\(error)")
            }
        }
        .resume()
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
        
        let placeholderImage = UIImage(systemName: "video.fill")
        cell.thumbnailImage.kf.setImage(with: product.thumbnailUrl, placeholder: placeholderImage)
        cell.thumbnailImage.kf.indicatorType = .activity
        cell.thumbnailImage.kf.setImage(with: product.thumbnailUrl,
                                        options: [.transition(.fade(0.5)), .forceTransition, .keepCurrentImageWhileLoading])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.videoInfoList[indexPath.row]
        presentAVPlayerViewController(videoURL: product.videoUrl)
    }
}



