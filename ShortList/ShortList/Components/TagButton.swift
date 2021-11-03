//
//  TagButton.swift
//  ShortList
//
//  Created by Silvia Florido on 03/11/21.
//

import UIKit


class TagButton: UIButton {
    var height: CGFloat = 40.0
    
    var chipColorStyle: TagColor = .white {
        didSet {
            applyColorStyle()
        }
    }
    
    var buttonTitle: String = "" {
        didSet {
            applyTitle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    init(title: String, chipColor: TagColor) {
        super.init(frame: .zero)
        
        self.buttonTitle = title
        self.chipColorStyle = chipColor
        
        setupViews()
    }
    
    override var buttonType: UIButton.ButtonType {
        return .custom
    }
    
    private func setupViews() {
        titleLabel?.font = .systemFont(ofSize: 15)
        layer.borderWidth = 2
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        applyTitle()
        applyColorStyle()
                
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        layer.cornerRadius = height/2
        adjustsImageWhenHighlighted = false
    }
    
    func update(title: String, chipColor: TagColor) {
        self.chipColorStyle = chipColor
        self.buttonTitle = title
    }
    
    private func applyColorStyle() {
        layer.borderColor = chipColorStyle.getForegroundColor().cgColor
        let titleColor = chipColorStyle.getForegroundColor()
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor, for: .highlighted)
        backgroundColor = chipColorStyle.getBackgroundColor()
        tintColor = chipColorStyle.getForegroundColor()
    }

    private func applyTitle() {
        UIView.performWithoutAnimation {
            setTitle(buttonTitle, for: .normal)
            setTitle(buttonTitle, for: .highlighted)
            let titleColor = chipColorStyle.getForegroundColor()
            setTitleColor(titleColor, for: .normal)
            setTitleColor(titleColor, for: .highlighted)
            layoutIfNeeded()
        }
    }
}

enum TagColor: String, CaseIterable {
    case purple
    case grey
    case white
    
    static func getChipColor(_ colorName: String?) -> (background: String, textColor: String) {
        let colorClass = TagColor.allCases.first(where: { $0.rawValue == colorName }) ?? .grey
        
        switch colorClass {
        case .purple:
            return ("EBDCFC", "9157D4")
        case .grey:
            return ("E7E9EF", "626772")
        case .white:
            return ("FFFFFF", "4F5963")
        }
    }
    
    func getForegroundColor() -> UIColor {
        let colorHex = TagColor.getChipColor(self.rawValue).textColor
        return UIColor(hexString: colorHex)
    }
    
    func getBackgroundColor() -> UIColor {
        let colorHex = TagColor.getChipColor(self.rawValue).background
        return UIColor(hexString: colorHex)
    }
}
