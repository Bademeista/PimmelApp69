//
//  ColorPicker.swift
//  PimmelApp 2.0
//
//  Created by Florian Rück on 14.10.20.
//

import UIKit



class ColorCell : UICollectionViewCell {
    
    @IBOutlet weak var colorButton: UIButton!
}

class ColorPickerController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return K.colorArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCelle", for: indexPath) as! ColorCell
        cell.colorButton.backgroundColor = K.colorArray[indexPath.item]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ColorCell
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        delegate?.pimmelColor = cell.colorButton.backgroundColor ?? .black
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ColorCell
        cell.layer.borderWidth = 0
    }
    
  
   
    
    var delegate : PimmelController?
    
    @IBOutlet weak var colorPicker: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPicker.delegate = self
        colorPicker.dataSource = self
        colorPicker.allowsMultipleSelection = false
    }
    
    
}


