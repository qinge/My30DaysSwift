//
//  ViewController.swift
//  Project 07 - PullToRefresh
//
//  Created by qinge on 2018/2/21.
//  Copyright © 2018年 qin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifer = "NewCellIdentifier"
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    var emojiData = [String]()
    
    var refreshControl = UIRefreshControl()

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "emoji"
        emojiData = favoriteEmoji
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
        }
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        self.refreshControl.addTarget(self, action: #selector(didRoadEmoji), for: .valueChanged)
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(Date())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let task = delay(5) {
            print("拨打110")
        }
        
        // 仔细想想 还是取消为妙
        cancel(task)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer)! as UITableViewCell
        
        cell.textLabel!.text = self.emojiData[indexPath.row]
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel!.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    //RoadEmoji
    
    @objc func didRoadEmoji() {
        let workQueue = DispatchQueue(label: "test")
        workQueue.async {
            Thread.sleep(forTimeInterval: 2)
            
            DispatchQueue.main.async {
                self.emojiData = self.newFavoriteEmoji
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
            
        }
        
    }
    

}

