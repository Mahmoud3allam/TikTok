//
//  ExploreContainerView.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 16/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import UIKit
class ExploreViewContainer: UIView {
    lazy var videoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collection.backgroundColor = .black
        collection.isPagingEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.isPrefetchingEnabled = false
        collection.bounces = false
        collection.contentMode = .scaleAspectFill
        collection.allowsSelection = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collection.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collection.register(VideoCell.self, forCellWithReuseIdentifier: NSStringFromClass(VideoCell.self))
        return collection
    }()
    lazy var muteImage:UIImageView = {
       var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.layer.cornerRadius = 8
        image.image = #imageLiteral(resourceName: "basic_eye-512")
        image.contentMode = .scaleAspectFit
        return image
    }()
    var isMuted = false
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.layoutUserInterFace()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func layoutUserInterFace() {
        self.addSubViews()
        self.setupCollectionView()
        self.setupMuteImage()
    }
    private func addSubViews(){
        self.addSubview(self.videoCollection)
    }
    private func setupCollectionView() {
        let statusBarHeight = self.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        NSLayoutConstraint.activate([
            self.videoCollection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor , constant: -statusBarHeight),
            self.videoCollection.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.videoCollection.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.videoCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    private func setupMuteImage() {
        self.addSubview(self.muteImage)
        NSLayoutConstraint.activate([
            self.muteImage.widthAnchor.constraint(equalToConstant: 100),
            self.muteImage.heightAnchor.constraint(equalToConstant: 100),
            self.muteImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.muteImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        self.muteImage.isHidden = true
    }
}
extension ExploreViewContainer : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.shared.getExploreVideos().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(VideoCell.self), for: indexPath) as? VideoCell
            if let url = URL(string: DataService.shared.getExploreVideos()[indexPath.item].videoURL) {
                cell?.configureCell(withVideo:url, isMuted:self.isMuted)
            }
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.videoCollection.frame.width, height: self.videoCollection.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
//        let visableVells = self.videoCollection.visibleCells
//        switch self.isMuted {
//        case true:
//            visableVells.forEach { (cell) in
//                if let cell = cell as? VideoCell {
//                    if let player = cell.playerContainer.player {
//                        player.isMuted = false
//                    }
//                }
//            }
//        case false:
//            visableVells.forEach { (cell) in
//                if let cell = cell as? VideoCell {
//                    if let player = cell.playerContainer.player {
//                        player.isMuted = true
//                    }
//                }
//            }
//
//        }
//        self.isMuted.toggle()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.prepareForReuse()
    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        self.videoCollection.visibleCells.forEach({ (cell) in
//            if cell.isKind(of: VideoCell.self) {
//                if let indexPath = self.videoCollection.indexPathsForVisibleItems.first {
//                    if let cell = cell as? VideoCell {
//                        if let url = URL(string: DataService.shared.getExploreVideos()[indexPath.item].videoURL) {
//                            cell.configureCell(withVideo: url)
//                        }
//                    }
//                }
//            }
//        })
//    }
}
