//
//  VideoInfoView.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 21/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import Foundation
import UIKit
class VideoInfoView: UIView {
    lazy var titleLabel:MarqueeLabel = {
       var label = MarqueeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Mahmoud Allam Asking Sayed Ragab"
        label.font = UIFont(name: "Tajawal-Regular", size: 17)
        label.textAlignment = .left
        label.speed = .duration(0)
        label.fadeLength = 80.0
        label.labelWillBeginScroll()
        label.type = .continuous
        return label
    }()
    lazy var topicLabel:UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "How to become an actor?"
        label.font = UIFont(name: "Tajawal-Bold", size: 17)
        label.textAlignment = .left
        return label
    }()
    lazy var titleLabelStack: UIStackView = {
       var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 6
        stack.axis = .horizontal
        return stack
    }()
    lazy var musicIcon:UIImageView = {
       var image = UIImageView()
        image.image = #imageLiteral(resourceName: "Nejmo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.layer.cornerRadius = 20
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.layoutUserInterFace()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        self.addSubview(self.topicLabel)
        self.addSubview(self.titleLabelStack)
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    private func layoutUserInterFace() {
        self.addSubViews()
        self.setupTopicLabel()
        self.setupTitleLabelStack()
        
    }
    private func setupTopicLabel() {
        NSLayoutConstraint.activate([
            self.topicLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.topicLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5),
            self.topicLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.topicLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
    }
    private func setupTitleLabelStack() {
        NSLayoutConstraint.activate([
            self.titleLabelStack.topAnchor.constraint(equalTo: self.topicLabel.bottomAnchor),
            self.titleLabelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabelStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        self.titleLabelStack.addArrangedSubview(self.musicIcon)
        self.titleLabelStack.addArrangedSubview(self.titleLabel)
    }
     func playAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.titleLabel.speed = .rate(80)
            self.musicIcon.rotate()
            self.musicIcon.setGradientBorder(.white, #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
        }
    }
    func stopAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.titleLabel.speed = .rate(0)
            self.musicIcon.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        }        
    }
    deinit {
        print("De init video Info.")
    }
    
    
}
