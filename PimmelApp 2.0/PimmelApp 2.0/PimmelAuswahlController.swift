//
//  PimmelAuswahlController.swift
//  PimmelApp 2.0
//
//  Created by Florian Rück on 14.10.20.
//

import UIKit

private let reuseIdentifier = "ImageCell"


class PimmelCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
}

class PimmelAuswahlController : UICollectionViewController{
    
    var delegate : PimmelController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem?.tintColor = .white
        collectionView.delegate = self
        collectionView.selectItem(at: IndexPath(item: delegate!.pictureId, section: 1), animated: true, scrollPosition: .centeredHorizontally)
        collectionView.allowsMultipleSelection = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            as! PimmelCell
        let pimmelImage = UIImage(named: "pimmel_" + String(indexPath.item))
        cell.imageView.image = pimmelImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! PimmelCell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        delegate?.pictureId = indexPath.item
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PimmelCell
        cell.layer.borderWidth = 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return K.pimmelAnzahl + 1
    }
    
    

}
