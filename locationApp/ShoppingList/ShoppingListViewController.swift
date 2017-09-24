//
//  ShoppingListViewController.swift
//  locationApp
//
//  Created by John Yong on 9/23/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {

    @IBOutlet var shoppingListGrid: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupShoppingListCollectionView()
    }
    
    private func setupShoppingListCollectionView() {
        shoppingListGrid.dataSource = self
        shoppingListGrid.delegate = self
    }
}

extension ShoppingListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
    
        
        let evenSectionEdgeInset = UIEdgeInsets(top: 20.0,
                                                left: 0.0,
                                                bottom: 10.0,
                                                right: 0.0)
        return evenSectionEdgeInset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: 500)
    }
}

extension ShoppingListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingListCell",
                                               for: indexPath as IndexPath) as? ShoppingListCell else {
                                                fatalError("Wrong class assigned to shopping list cell!")
        }
        return cell
    }
}
