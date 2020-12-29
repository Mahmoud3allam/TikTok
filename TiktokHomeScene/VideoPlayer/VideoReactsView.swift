//
//  VideoReactsView.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 17/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import UIKit
class VideoReactsView: UIView {
    lazy var verticalStackView: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 15
        return stack
    }()
//    lazy var reactButton:ReactsSingleView = {
//        var bu = ReactsSingleView()
//        bu.translatesAutoresizingMaskIntoConstraints  = false
//        bu.backgroundColor = .clear
//        bu.reactLabel.text = nil
//        bu.widthAnchor.constraint(equalToConstant: 60).isActive = true
//        return bu
//    }()
    lazy var downVoteButton:ReactsSingleView = {
        var bu = ReactsSingleView()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .clear
        bu.reactImage.image = UIImage(systemName: "icloud.and.arrow.down")
        bu.reactImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bu.reactLabel.isHidden = true
        bu.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return bu
    }()
    lazy var UpVoteButton:ReactsSingleView = {
        var bu = ReactsSingleView()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .clear
        bu.reactImage.contentMode = .scaleAspectFit
        bu.reactImage.image = UIImage(systemName: "arrow.up.message")
        bu.reactImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bu.reactLabel.isHidden = true
        bu.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return bu
    }()
    lazy var commentsButton:ReactsSingleView = {
        var bu = ReactsSingleView()
        bu.translatesAutoresizingMaskIntoConstraints  = false
        bu.backgroundColor = .clear
        bu.reactImage.image = UIImage(systemName: "plus.message")
        bu.reactImage.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        bu.reactLabel.isHidden = true
        bu.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return bu
    }()
    lazy var profileImageView:UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints  = false
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "Allam")
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    var delegete:ReactsViewTaps!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutUserInterFace()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layoutUserInterFace() {
        self.AddSubViews()
        self.setupStackView()
        self.setupProfileButton()
        self.downVoteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapDownVote)))
        self.UpVoteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapUpVote)))
        self.commentsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedComments)))
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapProfile)))
    }
    private func AddSubViews() {
        self.isUserInteractionEnabled = true
        self.addSubview(self.verticalStackView)
        self.addSubview(self.profileImageView)
    }
    private func setupStackView() {
        NSLayoutConstraint.activate([
            self.verticalStackView.heightAnchor.constraint(equalToConstant: (3*40 + 2*10)),
            self.verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.verticalStackView.addArrangedSubview(self.downVoteButton)
        self.verticalStackView.addArrangedSubview(self.commentsButton)
        self.verticalStackView.addArrangedSubview(self.UpVoteButton)
//        self.verticalStackView.addArrangedSubview(self.reactButton)

        
    }
    private func setupProfileButton() {
        NSLayoutConstraint.activate([
            self.profileImageView.bottomAnchor.constraint(equalTo: self.verticalStackView.topAnchor , constant: -15),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 60),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 60),
            self.profileImageView.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor)
        ])
        self.profileImageView.layer.cornerRadius = 30

    }
    func showAnimation(){
        self.profileImageView.setGradientBorder(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
        self.profileImageView.pulsate()
    }
    func hideAnimation() {
      //  self.profileButton.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
    }
    @objc func onTapDownVote() {
        delegete.didTappedDownVote()
    }
    @objc func onTapUpVote() {
        delegete.didTapUpVote()
    }
    @objc func onTapProfile() {
        delegete.didTapProfileImage()
    }
    @objc func onTappedComments() {
        delegete.onTappedComment()
    }
}

protocol ReactsViewTaps {
    func didTapProfileImage()
    func didTapUpVote()
    func didTappedDownVote()
    func onTappedComment()
}
