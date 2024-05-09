//
//  FYPresentAnimated.swift
//
//  Created by LXL on 2024/05/09.
//

import UIKit

enum PresentAnimateType {
    case present//被推出时
    case dismiss//取消时
}

//推出和取消动画
class FYPresentAnimated: NSObject,UIViewControllerAnimatedTransitioning {

    var type: PresentAnimateType = .present

    init(type: PresentAnimateType) {
        self.type = type
    }
    /// 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    /// 动画效果
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        switch type {
        case .present:
            guard let toVC: FYPickerViewController = transitionContext.viewController(forKey: .to) as? FYPickerViewController else {
                return
            }
            let toView = toVC.view

            let containerView = transitionContext.containerView
            containerView.addSubview(toView!)

            toVC.containView.transform = CGAffineTransform(translationX: 0, y: (toVC.containView.frame.height))

            UIView.animate(withDuration: 0.25, animations: {
                /// 背景变色
                toVC.backgroundView.alpha = 1.0
                /// addresspicker向上推出
                toVC.containView.transform =  CGAffineTransform(translationX: 0, y: -10)
            }) { (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    /// transform初始化
                    toVC.containView.transform = CGAffineTransform.identity
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
                })
            }
        case .dismiss:
            guard let toVC: FYPickerViewController = transitionContext.viewController(forKey: .from) as? FYPickerViewController else {
                return
            }

            UIView.animate(withDuration: 0.25, animations: {
                toVC.backgroundView.alpha = 0.0
                /// addresspicker向下推回
                toVC.containView.transform =  CGAffineTransform(translationX: 0, y: (toVC.containView.frame.height))
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
}
