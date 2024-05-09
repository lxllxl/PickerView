//
//  ViewController.swift
//
//  Created by Ethan.Wang on 2018/8/30.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 300, width: UIScreen.main.bounds.width - 200, height: 50))
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = UIColor(red: 255/255.0, green: 51/255, blue: 102/255, alpha: 1)
        return label
    }()
    let button: UIButton = {
        let button = UIButton(frame: CGRect(x: 150, y: 450, width: UIScreen.main.bounds.width - 300, height: 50))
        button.addTarget(self, action: #selector(onClickSelectAction), for: .touchUpInside)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("请选择", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(label)
        self.view.addSubview(button)
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func onClickSelectAction() {
        let addressPicker = FYPickerViewController( dataSource: ["A","B","C","D","E","F"],title: "请选择" )
        addressPicker.backResult = { (value) in
            self.label.text = value
        }
        self.present(addressPicker, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
