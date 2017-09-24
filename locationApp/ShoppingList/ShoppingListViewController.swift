//
//  ShoppingListViewController.swift
//  locationApp
//
//  Created by John Yong on 9/23/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit
import HyperTrack

class ShoppingListViewController: UIViewController {

    @IBOutlet var shoppingListGrid: UICollectionView!
    var allShoppingLists: [String: [String]]! // Storename to list of items
    
    @IBAction func confirmOrderBtnPressed() {
        createRandomPlaceOnMap(placeOnMap: "3301 Hillview Ave, Building Two Palo Alto, CA 94303")
        createRandomPlaceOnMap(placeOnMap: "Jack's Golf Gear, El Centro Street, Palo Alto, CA")
        createRandomPlaceOnMap(placeOnMap: "4119 El Camino Real, Palo Alto, CA 94306")
    }
    
    func createRandomPlaceOnMap(placeOnMap: String) {
        // send allShoppingListsToFirebase
    
        // Random UUID
        let orderID: String = UUID().uuidString
        HyperTrack.startMockTracking()
        // Construct a place object for Action's expected place.
        // @NOTE: Pass either the address or the location for the expected place.
        // Both have been passed here only to show how it can be done, in case
        // the data is available.
        let expectedPlace: HyperTrackPlace = HyperTrackPlace().setAddress(address:
            placeOnMap)
        
        // Create ActionParams object specifying the Delivery Type Action parameters including ExpectedPlace,
        // ExpectedAt time and Lookup_id.
        let htActionParams = HyperTrackActionParams()
        htActionParams.expectedPlace = expectedPlace
        htActionParams.type = "delivery"
        htActionParams.lookupId = "0"
        
        // Call createAndAssignAction to assign Delivery action to the current
        // user configured in the SDK using the Place object created above.
        HyperTrack.createAndAssignAction(htActionParams) { action, error in
            
            if let error = error {
                // Handle createAndAssignAction API error here
                self.showAlert(message: error.errorMessage)
                return
            }
            
            if let action = action {
                // Handle createAndAssignAction API success here
                print(action)
                self.showAlert(message: "You have create an action. Mark it complete once it is completed!")
                
                // Save Action id and use this to query the stats of the action later.
                UserDefaults.standard.set(action.id!, forKey: "hypertrack_action_id")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShoppingListCollectionView()
        hideKeyboardWhenTappedAround()
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
        
        return CGSize(width: 200, height: 250)
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
        cell.shoppingListDelegate = self
        return cell
    }
}

extension ShoppingListViewController: ShoppingListDelegate {
    func updateShoppingLists(list: [String]) {
        var list = list
        let storeName = list.removeFirst()
        allShoppingLists[storeName] = list
    }
}
