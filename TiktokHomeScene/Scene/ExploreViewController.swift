//
//  ViewController.swift
//  TiktokHomeScene
//
//  Created by Alchemist on 16/12/2020.
//  Copyright © 2020 Nejmo. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
     let containerView: ExploreViewContainer = {
        var view = ExploreViewContainer(frame: .zero)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view.
    }
    override func loadView() {
        super.loadView()
        self.view = containerView
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.containerView.videoCollection.reloadData()
        }
    }
    
    
}

