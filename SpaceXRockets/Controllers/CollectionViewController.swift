//
//  HorizontalCollectionViewController.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 27.08.2022.
//

import UIKit

protocol CollectionViewControllerDelegate : AnyObject {
    func update()
}

class CollectionViewController: UIViewController {
    var parameters: [Parameters] = []
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        return collection
    }()
    
    //MARK: override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefaultUnits()
        setUpView()
        setupConstraints()
        setupNotification()
    }
    
    //MARK: private methods
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollection), name: Notification.Name.settingsNotification, object: nil)
        
    }
    
    @objc func updateCollection(notification: Notification) {
        collectionView.reloadData()
    }
    
    
    private func setupDefaultUnits() {
        if !parameters.isEmpty {
            let item = UserDefaults.standard.string(forKey: parameters[0].name)
            if item == nil {
                for parameter in parameters {
                    UserDefaults.standard.set(parameter.firstValue.value, forKey: parameter.name)
                }
            }
        }
    }
 
    private func setUpView() {
        collectionView.register(RocketParametersCollectionCell.self, forCellWithReuseIdentifier: RocketParametersCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.backgroundColor = .black
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: Collection data source

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parameters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketParametersCollectionCell.identifier, for: indexPath) as? RocketParametersCollectionCell {
            cell.configure(with: parameters[indexPath.row], numberOfSegment: indexPath.row)
            return cell
        }
        return RocketParametersCollectionCell()
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

