//
//  MainCollectionView.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 08.09.2022.
//

import UIKit


protocol MainCollectionViewControllerDelegate: AnyObject {
    func showLaunchInfo()
}

class MainCollectionViewController : UIViewController {
  
    //MARK: private properties
    
    private var pageControl = UIPageControl()

    private var rockets: [Rocket] = [] {
        didSet {
            pageControl.numberOfPages = rockets.count
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.contentInsetAdjustmentBehavior = .never
    
        return collection
    }()
    
    //MARK: override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRockets()
        setUpCollectionView()
        configurePageControl()
   
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0,
                                      y: 0,
                                      width: view.frame.width,
                                      height: view.frame.height - 50)
        pageControl.frame = CGRect(x: 0,
                                   y: view.frame.height - 50,
                                   width: view.frame.width,
                                   height: 50)
    }
    //MARK: private methods
 
    private func fetchRockets() {
        RocketService().load { [weak self] result in
            DispatchQueue.main.async {
                self?.rockets = result
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func configurePageControl() {
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        view.addSubview(pageControl)
        pageControl.backgroundColor = .init(white: 1, alpha: 0.1)
        pageControl.clipsToBounds = true
    }

    @objc func pageControlDidChange(_ sender: UIPageControl) {
        
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
    }
    
    private func setUpCollectionView() {
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(collectionView)
        view.backgroundColor = .black
    }
}
   
// MARK: Collection data source

extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return rockets.count
    }
        
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifier, for: indexPath) as? MainCollectionCell {
            cell.configure(with: rockets[indexPath.row])
            cell.rocketTableViewController.mainCollectionViewControllerDelegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
        collectionView.tag = pageControl.currentPage
    }
}

// MARK: Collection flow layout

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainCollectionViewController: MainCollectionViewControllerDelegate {
    func showLaunchInfo() {
        let vc = LaunchesViewController()
        vc.rocket = rockets[collectionView.tag]
        navigationController?.pushViewController(vc, animated: true)
    }
}

