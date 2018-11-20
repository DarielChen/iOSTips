//
//  ViewController.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2018/9/28.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonStr = """
                    {
                        "code": 200,
                        "msg": "success",
                        "data": {
                                  "title": "title",
                                  "type": 0,
                                  "id": 3930883,
                        }
                    }
                    """.getDictFromJSONString()
    }
}

extension String {
    public func getDictFromJSONString() -> NSDictionary? {
        let jsonData: Data = self.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
        if dict != nil {
            return dict as? NSDictionary
        }
        return dict as? NSDictionary
    }
}
