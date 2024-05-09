//
//  FYPickerView
//
//  Created by 李小龙 on 2024/5/8.
//  Copyright © 2024年 Ethan. All rights reserved.
//

import UIKit


class FYPickerView: UIView {
    
    /// 返回数据回调
    public var backLocationString: ((String) -> Void)?
    /// 退出回调
    public var backOnClickCancel: (() -> Void)?
    
    /// 选择的值
    var selectedValue: String?

    /// 当前tableView使用的数据源
    private var dataArray: [String]?
    
    /// 标题
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: (UIScreen.main.bounds.width - 100) / 2, y: 9, width: 100, height: 24))
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    /// 确定
    private let sureBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 76, y: 11, width: 60, height: 30))
        button.setTitle( "确定", for: .normal)
        button.setTitleColor(.green, for: .normal)
        return button
    }()
    
    /// 取消
    private let cancelBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 16, width: 60, height: 30))
        button.setTitle( "取消", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    /// 遮罩
    private let MaskingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        view.backgroundColor = .white
        return view
    }()
    
    private var pickerView = UIPickerView(frame: CGRect(x: 0, y:0 , width: UIScreen.main.bounds.width, height: 240))
    
    init(frame: CGRect, dataSource:[String], title: String) {
        
        super.init(frame: frame)
        self.dataArray = dataSource
        self.backgroundColor = UIColor.white
        self.titleLabel.text = title
        
        self.addSubview(pickerView)
        self.addSubview(MaskingView)
        pickerView.dataSource = self
        pickerView.delegate = self
        self.MaskingView.addSubview(titleLabel)
        self.MaskingView.addSubview(sureBtn)
        self.MaskingView.addSubview(cancelBtn)
        sureBtn.addTarget(self, action: #selector(onClickSureButton), for: .touchUpInside)
        cancelBtn.addTarget(self, action: #selector(onClickCancelButton), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 确认
    @objc private func onClickSureButton() {
        if self.backLocationString != nil {
            backLocationString!(self.selectedValue ?? "")
        }
    }
    
    /// 关闭
    @objc private func onClickCancelButton() {
        if self.backOnClickCancel != nil {
            backOnClickCancel!()
        }
    }
}
// MARK: - tableViewDelegate
extension FYPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArray!.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Item \(self.dataArray![row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = self.dataArray?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 48.0
    }
}
