//
//  ViewController.swift
//  YeggrrrAVPlayerApp
//
//  Created by YJ on 5/1/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var videoListTableView: UITableView!
    
    var videoInfoList: [VideoInfo] = []
    let urlString = "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json"
    override func viewDidLoad() {
        super.viewDidLoad()
        videoListTableView.dataSource = self
        videoListTableView.delegate = self
        getData()
        
    }
    
    func getData() {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, request, error in
            guard let data = data else { return }
            print(data)
            guard let error = error else { return }
            print(error)
            
            
            do {
                let decorder = JSONDecoder()
                let result = try decorder.decode(VideoInfo.self, from: data)
                print(result)
            } catch {
                print("error:\(error)")
            }
        }
        .resume()
    }
}

extension ViewController:  UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier, for: indexPath) as? VideoTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

