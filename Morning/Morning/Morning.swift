//
//  Morning.swift
//  Morning
//
//  Created by Bruce Jackson on 2017/9/19.
//  Copyright © 2017年 zysios. All rights reserved.
//

import UIKit

typealias MorningHandler = (Bool) -> ()

class Morning: UIView {

    var dismissOnTouchOutside = true

    private(set) var contentView: UIView = UIView(frame: .zero)

    private var containerView = UIView(frame: .zero)
    private var shadowView = UIView(frame: .zero)

    //MARK: Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .clear

        addSubview(containerView)
        containerView.addSubview(shadowView)
        containerView.addSubview(contentView)

        containerView.addObserver(self, forKeyPath: "frame", context: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Deinit
    deinit {
        containerView.removeObserver(self, forKeyPath: "frame")
        removeObserver(self, forKeyPath: "frame")
    }

    //MARK: Public Methods
    func show(inView view: UIView) {
        view.addSubview(self)

        frame = view.bounds

        view.addObserver(self, forKeyPath: "frame", context: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(tapGestureRecognizer:)))
        addGestureRecognizer(tapGesture)
    }

    func dismiss() {
        guard superview != nil else {
            return
        }

        superview!.removeObserver(self, forKeyPath: "frame")
        removeFromSuperview()
    }

}

//MARK: KVO
extension Morning {

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard keyPath == "frame" else {
            return
        }

        guard let theView = object as? UIView else {
            return
        }

        if theView == containerView {
            shadowView.frame = containerView.bounds
            contentView.frame = containerView.bounds
        } else if theView == self {
            frame = superview!.bounds
        }
    }

}

//MARK: Touch Event
private extension Morning {

    @objc func tapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard dismissOnTouchOutside else {
            return
        }

        dismiss()
    }

}
