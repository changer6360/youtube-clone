//
//  HomeController.swift
//  YouTube
//
//  Created by Tihomir Videnov on 10/26/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Properties
//    var videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeWestChannel"
//        kanyeChannel.profileImageName = "kanye_profile"
//        
//       var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift -  Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_example_image"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 2342342
//        
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood feat. Kandrick Lamar"
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 123123
//        
//        return [blankSpaceVideo, badBloodVideo]
//    }()

    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    let cellId = "cellId"
    let trendingCellId = "trendingCellId"
    let subscriptionCellId = "subscriptionCellId"
    
    lazy var settingsLauncher: SettingsLauncher = {
       let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    //MARK:- View functions
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    // MARK:- Custom functions
    
    func setupCollectionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isPagingEnabled =  true
        
        collectionView?.backgroundColor = UIColor.white

        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreButton, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    func handleMore() {
        //show menu  
       settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = UIColor.white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    
    func handleSearch() {
        //bring the search view
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        
        setTitleFor(index: menuIndex)
    }
    
    private func setTitleFor(index:Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    private func setupMenuBar() {
        
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
    //MARK:- ScrollView functions
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //print(targetContentOffset.pointee.x / view.frame.width)
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
          setTitleFor(index: Int(index))
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
   
    //MARK:- CollectionView functions
   
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 1 {
            identifier = trendingCellId
        } else if indexPath.item == 2 {
            identifier = subscriptionCellId
        } else {
            identifier = cellId
        }
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }


}

