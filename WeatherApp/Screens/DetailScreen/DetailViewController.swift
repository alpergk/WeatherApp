//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Alper Gok on 20.03.2025.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum Section { case main }
    
    private let detailView: DetailView
    private var dataSource: UICollectionViewDiffableDataSource<Section, WeatherProperty>!
    private let detailViewModel: DetailViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDataSource()
        
        
    }
    
    init(detailView: DetailView, detailViewModel: DetailViewModel) {
        self.detailView = detailView
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.pinToEdges(of: view)
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: detailView.bottomCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPropertyCell.reuseID, for: indexPath) as? DetailPropertyCell else {
                return UICollectionViewCell()
            }
            cell.set(image: item.icon!, description: item.description)
            return cell
        })
    }
    
    public func updateData(with properties: [WeatherProperty]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherProperty>()
        snapshot.appendSections([.main])
        snapshot.appendItems(properties)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
}




