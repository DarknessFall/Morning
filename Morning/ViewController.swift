//
//  ViewController.swift
//  Morning
//
//  Created by Bruce Jackson on 2017/9/19.
//  Copyright © 2017年 zysios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let alert = Morning()
        alert.backgroundColor = .blue

        alert.show(inView: view)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }
}

