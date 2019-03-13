//
//  FeatureViewController.swift
//  AddHomeShortcuts
//
//  Created by Dariel on 2019/3/12.
//  Copyright © 2019 Dariel. All rights reserved.
//

import UIKit
import Swifter

class FeatureViewController: UIViewController {
    lazy var server = HttpServer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func addShortcutsTouch(_ sender: Any) {
        
        guard let deeplink = URL(string: "addshortcuts://profile") else {
            return
        }
        guard let shortcutUrl = URL(string: "http://localhost:8244/s") else {
            return
        }
        
        guard let iconData = UIImage(named: "feature_icon")?.jpegData(compressionQuality: 0.5) else {
            return
        }
        
        let html = htmlFor(title: "功能快捷方式", urlToRedirect: deeplink.absoluteString, icon: iconData.base64EncodedString())
        
        guard let base64 = html.data(using: .utf8)?.base64EncodedString() else {
            return
        }
        server["/s"] = { request in
            return .movedPermanently("data:text/html;base64,\(base64)")
        }
        try? server.start(8244)
        UIApplication.shared.open(shortcutUrl)

    }
    
    func htmlFor(title: String, urlToRedirect: String, icon: String) -> String {
        let shortcutsPath = Bundle.main.path(forResource: "shortcuts", ofType: "html")
        
        var shortcutsContent = try! String(contentsOfFile: shortcutsPath!) as String
        shortcutsContent = shortcutsContent.replacingOccurrences(of: "\\(title)", with: title)
        shortcutsContent = shortcutsContent.replacingOccurrences(of: "\\(urlToRedirect.absoluteString)", with: urlToRedirect)
        shortcutsContent = shortcutsContent.replacingOccurrences(of: "\\(feature_icon)", with: icon)

        print(shortcutsContent)
        return shortcutsContent
    }
    
    
    
}
