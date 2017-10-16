//
//  Morning.swift
//  Morning
//
//  Created by Bruce Jackson on 2017/9/19.
//  Copyright © 2017年 zysios. All rights reserved.
//

import UIKit

typealias MorningHandler = (Bool) -> ()

class MorningAlert: UIView {

    var contentView: UIView = UIView()

    var dismissOnTouchOutside = true

    ///Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///Public Methods
    func show(inView view: UIView = UIApplication.shared.keyWindow!) {
        view.addSubview(self)

        frame = view.bounds

        view.addObserver(self, forKeyPath: "frame", context: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(tapGestureRecognizer:)))
        addGestureRecognizer(tapGesture)
    }

    func dismiss() {

    }

}

///MARK: KVO
extension MorningAlert {

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            frame = superview!.bounds
        }
    }

}

private extension MorningAlert {

    @objc func tapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard dismissOnTouchOutside else {
            return
        }

        dismiss()
    }

}
