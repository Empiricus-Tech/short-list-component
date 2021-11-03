//
//  ViewController.swift
//  ShortList
//
//  Created by Silvia Florido on 03/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var shortListView: ShortListView = {
        let view = ShortListView()
        view.bodyAlignment = .leading
        view.itemsSpacing = 16
        return view
    }()
    
    
    var demoListData = ["Opção 1", "Opção 2", "Opção 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateViews()
    }

    private func setupViews() {
        view.addSubview(shortListView)
        
        shortListView.translatesAutoresizingMaskIntoConstraints = false
        shortListView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        shortListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        shortListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        let bottom = shortListView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -20)
        bottom.priority = UILayoutPriority.defaultLow
        bottom.isActive = true
    }
    
    private func updateViews() {
        var views = [UILabel]()
        
        demoListData.forEach { data in
            let label = UILabel()
            label.font = .systemFont(ofSize: 15)
            label.textColor = .darkGray
            label.text = data
            views.append(label)
        }
        
        shortListView.bodyViews = views
        
        shortListView.bodyTitle = "Essa é uma short list de UILabels"
    }

}

