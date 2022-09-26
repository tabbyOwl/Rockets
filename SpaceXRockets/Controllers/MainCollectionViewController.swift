//
//  MainCollectionView.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 08.09.2022.
//

import UIKit

class MainCollectionViewController : UIViewController {
    
    private var pageControl = UIPageControl()
    
    let rocketVC = RocketDataTableViewController()
    
    private var rockets: [Rocket] = [] {
        didSet {
            pageControl.numberOfPages = rockets.count
        }
    }
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.contentInsetAdjustmentBehavior = .never
    
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchRockets()
        setupNavigationController()
        setupNotification()
        setUpCollectionView()
        configurePageControl()
       setupConstraints()
    }

    private func setupNavigationController() {
        navigationItem.backButtonTitle = "Назад"
    }
    
    private func fetchRockets() {
        
        RocketService().load { [self] result in
            
                DispatchQueue.main.sync {
                    self.rockets = result.reversed()
                    }
                    self.collectionView.reloadData()
                }
    }
    
    private func setupNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushLaunchesViewController), name: Notification.Name("TableFooterNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushSettingsViewController), name: Notification.Name("SettingsImageNotification"), object: nil)
        
    }
    
    @objc private func pushLaunchesViewController() {
        
        let vc = LaunchesViewController()
        vc.rocket = rockets[collectionView.tag]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func pushSettingsViewController() {
        
        let vc = SettingsTableViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationController?.present(navigationVC, animated: true)
    }
    
    private func configurePageControl() {
        
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        view.addSubview(pageControl)
        pageControl.backgroundColor = .init(white: 1, alpha: 0.1)
        pageControl.clipsToBounds = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    private func setupConstraints() {

        pageControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),

            pageControl.heightAnchor.constraint(equalToConstant: 50),
            pageControl.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
    
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        pageControl.currentPage = indexPath.row
        
        collectionView.tag = pageControl.currentPage
    }
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.size.width, height: collectionView.frame.size.height)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
