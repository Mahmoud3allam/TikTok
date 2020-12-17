//
//  VideoPlayerHeader.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 17/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import UIKit
class VideoPlayerHeader: UIView {
    lazy var fanImage:UIImageView = {
       var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "avatars-000233039861-pz3q20-t500x500")
        return image
    }()
    lazy var talentImage:UIImageView = {
       var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .blue
        image.image = #imageLiteral(resourceName: "avatars-0A2HbZEFcHXzGayI-TkisRA-t500x500")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var titleLabel:UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Mahmoud Allam Asking Sayed Ragab"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    lazy var topicLabel:UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.text = "How to become an actor?"
        label.textAlignment = .left
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layoutUserInterFace()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layoutUserInterFace() {
        self.addSubViews()
        self.setupFanImageView()
        self.setupTalentImageView()
        self.setupTitleLabel()
        self.setupTopicLabel()
    }
    private func addSubViews() {
        self.addSubview(self.fanImage)
        self.addSubview(self.talentImage)
        self.addSubview(self.titleLabel)
        self.addSubview(self.topicLabel)

    }
    private func setupFanImageView() {
        NSLayoutConstraint.activate([
            self.fanImage.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 12),
            self.fanImage.heightAnchor.constraint(equalToConstant: 45),
            self.fanImage.widthAnchor.constraint(equalToConstant: 45),
            self.fanImage.topAnchor.constraint(equalTo: self.topAnchor , constant: 5)
        ])
        self.fanImage.layer.cornerRadius = 22.5
    }
    private func setupTalentImageView() {
        NSLayoutConstraint.activate([
            self.talentImage.leadingAnchor.constraint(equalTo: self.fanImage.trailingAnchor , constant: -10),
            self.talentImage.heightAnchor.constraint(equalToConstant: 45),
            self.talentImage.widthAnchor.constraint(equalToConstant: 45),
            self.talentImage.topAnchor.constraint(equalTo: self.fanImage.topAnchor , constant: 0)
        ])
        self.talentImage.layer.cornerRadius = 22.5
        self.talentImage.layer.borderColor = UIColor.black.cgColor
        self.talentImage.layer.borderWidth = 1
    }
    private func setupTitleLabel() {
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.fanImage.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.talentImage.trailingAnchor,constant: 8),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    private func setupTopicLabel() {
        NSLayoutConstraint.activate([
        
            self.topicLabel.leadingAnchor.constraint(equalTo: self.fanImage.leadingAnchor , constant: 4),
            self.topicLabel.topAnchor.constraint(equalTo: self.fanImage.bottomAnchor , constant: 5),
            self.topicLabel.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
}
