//
//  ShortListView.swift
//  ShortList
//
//

import UIKit

@IBDesignable
public class ShortListView: UIView {
    @IBInspectable public var messageLineSpacing: CGFloat = 6
    @IBInspectable public var showSeparator: Bool = false {
        didSet {
            updateBodyStack()
        }
    }
    @IBInspectable public var itemsSpacing: CGFloat = 16 {
        didSet {
            bodyStackView.spacing = showSeparator ? max(itemsSpacing/2, 0) : itemsSpacing
        }
    }
    @IBInspectable public var separatorColor: CGColor = UIColor.lightGray.cgColor {
        didSet {
            updateBodyStack()
        }
    }
    @IBInspectable public var bodyTitle: String? {
        didSet {
            titleLabel.text = bodyTitle
            updateRootStack()
        }
    }
    
    public var bodyPadding: UIEdgeInsets = .zero {
        didSet {
            rootStackView.layoutMargins = bodyPadding
        }
    }
    
    public var bodyAlignment: UIStackView.Alignment = .fill {
        didSet {
            bodyStackView.alignment = bodyAlignment
        }
    }
    
    public lazy var bodyViews: [UIView] = [] {
        didSet {
            bodyViews.forEach({ $0.layoutMargins =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) })
            updateBodyStack()
        }
    }
    // MARK: - Views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    lazy var bodyStackView: UIStackView = {
        let arrangedSubviews = bodyViews
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.spacing = showSeparator ? max(itemsSpacing/2, 0) : itemsSpacing
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
        return stackView
    }()
    
    lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[titleLabel, bodyStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private func updateRootStack() {
        rootStackView.arrangedSubviews.forEach { (view) in
            rootStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        if let title = bodyTitle, !title.isEmpty {
            rootStackView.addArrangedSubview(titleLabel)
        }
        
        rootStackView.addArrangedSubview(bodyStackView)
    }
    
    
    func updateBodyStack() {
        bodyStackView.arrangedSubviews.forEach { (view) in
            bodyStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        bodyViews.forEach { (view) in
            bodyStackView.addArrangedSubview(view)
            if showSeparator {
                bodyStackView.addArrangedSubview(createSeparator())
            }
        }
    }
    
    func createSeparator() -> UIView {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(cgColor: separatorColor)
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        return separatorView
    }
    
    // MARK: - Setup
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        constraints.append(rootStackView.topAnchor.constraint(equalTo: topAnchor))
        constraints.append(rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor))
        constraints.append(rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor))
        constraints.append(rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor))

        addSubview(rootStackView)
        addConstraints(constraints)
        updateBodyStack()
        updateRootStack()
    }
}
