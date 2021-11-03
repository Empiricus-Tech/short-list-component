//
//  ViewController.swift
//  ShortList
//
//  Created by Silvia Florido on 03/11/21.
//

import UIKit

enum ListStyle: Int, CaseIterable {
    case labelLeft = 0
    case labelCentered
    case tagButton
    case mixedViews
}

class ViewController: UIViewController {
    
    @IBOutlet weak var shortListView: ShortListView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var demoListData = ["Opção 1", "Opção 2", "Opção 3", "Opção 4"]
    
    lazy var leftSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .left
        gesture.addTarget(self, action: #selector(swipedLeft))
        return gesture
    }()
    
    lazy var rightSwipeGestureRecognizer: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .right
        gesture.addTarget(self, action: #selector(swipedRight))
        return gesture
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews(0)
    }

    private func setupViews() {
        view.addGestureRecognizer(leftSwipeGestureRecognizer)
        view.addGestureRecognizer(rightSwipeGestureRecognizer)
        
        pageControl.numberOfPages = ListStyle.allCases.count
        
        shortListView.itemsSpacing = 16
    }
    
    private func updateViews(_ style: Int) {
        let style = ListStyle.allCases.first(where: {$0.rawValue == style}) ?? .labelLeft
        
        switch style {
        case .labelLeft:
            labelLeftList()
        case .labelCentered:
            labelCenteredList()
        case .tagButton:
            tagButtonList()
        case .mixedViews:
            mixedViewsList()
        }
    }
    
    private func labelLeftList() {
        shortListView.bodyAlignment = .leading
        shortListView.titleLabel.textAlignment = .left

        var views = [UILabel]()
        
        demoListData.forEach { data in
            let label = UILabel()
            label.font = .systemFont(ofSize: 15)
            label.textColor = .darkGray
            label.text = data
            views.append(label)
        }
        
        shortListView.bodyViews = views
        
        shortListView.bodyTitle = "Short list de UILabels com alinhamento à esquerda"
    }
    
    private func labelCenteredList() {
        shortListView.bodyAlignment = .center
        shortListView.titleLabel.textAlignment = .center
        
        var views = [UILabel]()
        
        demoListData.forEach { data in
            let label = UILabel()
            label.font = .systemFont(ofSize: 15)
            label.textColor = .darkGray
            label.text = data
            views.append(label)
        }
        
        shortListView.bodyViews = views
    
        shortListView.bodyTitle = "Short list de UILabels com alinhamento centralizado"
    }
    
    private func tagButtonList() {
        shortListView.bodyAlignment = .leading
        shortListView.titleLabel.textAlignment = .left
        
        var views = [TagButton]()
        
        demoListData.forEach { data in
            let button = TagButton()
            button.buttonTitle = data
            button.addTarget(self, action: #selector(changeButtonState), for: .touchUpInside)
            views.append(button)
        }
        
        shortListView.bodyViews = views
        
        shortListView.bodyTitle = "Short list de UIButton customizado"
    }
    
    private func mixedViewsList() {
        shortListView.bodyAlignment = .leading
        shortListView.titleLabel.textAlignment = .left
        
        var views = [UIView]()
        
        for (index, element) in demoListData.enumerated() {
            if [0,1].contains(index) {
                let label = UILabel()
                label.font = .systemFont(ofSize: 15)
                label.textColor = .darkGray
                label.text = element
                views.append(label)
            } else {
                let button = TagButton()
                button.buttonTitle = element
                button.addTarget(self, action: #selector(changeButtonState), for: .touchUpInside)
                views.append(button)
            }
        }
        
        shortListView.bodyViews = views
        
        shortListView.bodyTitle = "Short list de views mistas"
    }
    
    // MARK:- Actions
    @objc func changeButtonState(_ sender: TagButton) {
        sender.isSelected.toggle()
        sender.chipColorStyle = sender.isSelected ? .purple : .white
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if pageControl.numberOfPages > pageControl.currentPage {
                pageControl.currentPage += 1
            }
        }
        updateViews(pageControl.currentPage)
    }
    
    @objc func swipedRight(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if pageControl.currentPage > 0 {
                pageControl.currentPage -= 1
            }
        }
        updateViews(pageControl.currentPage)
    }
}

