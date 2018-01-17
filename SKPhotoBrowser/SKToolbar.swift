//
//  SKToolbar.swift
//  SKPhotoBrowser
//
//  Created by keishi_suzuki on 2017/12/20.
//  Copyright © 2017年 suzuki_keishi. All rights reserved.
//

import Foundation

// helpers which often used
private let bundle = Bundle(for: SKPhotoBrowser.self)

class SKToolbar: UIToolbar {
    var toolActionButton: UIBarButtonItem!
    var toolUpvoteButton: UIBarButtonItem!
    
    let upvoteImage = SKUpvoteButton().currentImage
    let upvoteButton = UIButton(type: .custom)
    
    fileprivate weak var browser: SKPhotoBrowser?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, browser: SKPhotoBrowser) {
        self.init(frame: frame)
        self.browser = browser
        
        setupApperance()
        setupToolbar()
    }
}

private extension SKToolbar {
    func setupApperance() {
        backgroundColor = .clear
        clipsToBounds = true
        isTranslucent = true
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
    }
    
    func setupToolbar() {
        toolActionButton = UIBarButtonItem(barButtonSystemItem: .action, target: browser, action: #selector(SKPhotoBrowser.actionButtonPressed))
        toolActionButton.tintColor = UIColor.white
        
        upvoteButton.setImage(upvoteImage, for: .normal)
        upvoteButton.frame = CGRect(x: 0, y: 0, width: (upvoteImage?.size.width)!, height: (upvoteImage?.size.height)!)
        upvoteButton.addTarget(browser, action: #selector(SKPhotoBrowser.upvoteButtonPressed), for: .touchUpInside)
        
        toolUpvoteButton = UIBarButtonItem(customView: upvoteButton)
        toolUpvoteButton.tintColor = UIColor.white
        
        var items = [UIBarButtonItem]()
        //items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
        if SKPhotoBrowserOptions.displayAction {
            items.append(toolUpvoteButton)
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: browser, action: nil))
            items.append(toolActionButton)
        }
        setItems(items, animated: false)
    }
    
    func setupActionButton() {
    }
}

