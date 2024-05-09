//
//  FYPickerViewController.swift
//
//  Created by 李小龙 on 2024/5/8.
//  Copyright © 2024年 Ethan. All rights reserved.
//

import UIKit


class FYPickerViewController: UIViewController {

    public var backResult: ((String) -> Void)?
    // 数据源
    var dataSource: [String]?
    // 标题
    var titleString: String?

    public lazy var containView: FYPickerView = {
        let view = FYPickerView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 280, width: UIScreen.main.bounds.width, height: 280),dataSource: self.dataSource!,title: self.titleString ?? "" )
        view.backOnClickCancel = {
            [weak self] in
            self?.onClickCancel()
        }
        /// 成功选择后将数据回调,并退出视图
        view.backLocationString = {[weak self] (value) in
            if self?.backResult != nil {
                self?.backResult!(value)
                self?.onClickCancel()
            }
        }
        return view
    }()
    
    public var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()

    init(dataSource: [String], title: String) {
        super.init(nibName: nil, bundle: nil)
        self.dataSource = dataSource
        self.titleString = title
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.insertSubview(self.backgroundView, at: 0)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom//viewcontroller弹出后之前控制器页面不隐藏
        
        self.containView.backOnClickCancel = {
            [weak self] in
            self?.onClickCancel()
        }
        /// 成功选择后将数据回调,并推出视图
        self.containView.backLocationString = {[weak self] (value) in
            if self?.backResult != nil {
                self?.backResult!(value)
                self?.onClickCancel()
            }
        }
        self.view.addSubview(self.containView)
        // 转场动画代理
        self.transitioningDelegate = self
    }

    ///点击推出
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let currentPoint = touches.first?.location(in: self.view)
        if !self.containView.frame.contains(currentPoint ?? CGPoint()) {
            self.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: onClick
    @objc private func onClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
// MARK: - 转场动画delegate
extension FYPickerViewController:UIViewControllerTransitioningDelegate {
    /// 推入动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = FYPresentAnimated(type: .present)
        return animated
    }
    /// 推出动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = FYPresentAnimated(type: .dismiss)
        return animated
    }
}
