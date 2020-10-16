//
//  PimmelController.swift
//  PimmelApp 2.0
//
//  Created by Florian Rück on 14.10.20.
//

import UIKit

class PimmelController : UIViewController {
    
    //MARK: - Variables
    
    private var isTouching = false
    private enum directions {
        case up
        case down
    }
    private var sliderMovement : directions = .up
    private var sliderTimer : DispatchSourceTimer?
    var pictureId = 0
   
    let pictureName = "pimmel_"
    let angleIncrement : CGFloat = 0.2
    let timeForAnimation = 0.025
    let sliderSpeed = 1 //Zeit in Sekunden für einen Durchlauf in eine Richtung
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!

    @IBOutlet weak var paintView: UIView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var pimmelSelectButton: UIButton!
    
    
    //MARK: - Outlet actions
    
    @IBAction func randomSizePressed(_ sender: UIButton) {
        startTimer()
    }
    @IBAction func clearPressed(_ sender: UIButton) {
        for pictures in paintView.subviews{
            pictures.removeFromSuperview()
        }
    }
    @IBAction func sliderChanged(_ sender: UISlider) {
        setSizeLabel()
    }
    @IBAction func sliderTouched(_ sender: UISlider) {
        stopTimer()
    }
    
    
    //MARK: - Coding
    
    override func viewDidLoad() {
        clearButton.layer.cornerRadius = 10
        pimmelSelectButton.layer.cornerRadius = 10
        paintView.clipsToBounds = true
        navigationItem.titleView?.tintColor = .white
        startTimer()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let imageSize = CGFloat(20.0 + sizeSlider.value * 2)
        let imageX = touch.location(in: paintView).x - (imageSize * 0.5)
        let imageY = touch.location(in: paintView).y - (imageSize * 0.5)
        let picFrame = CGRect(x: imageX, y: imageY, width: imageSize, height: imageSize)
        
        let imageView = UIImageView(frame: picFrame)
        var pimmelNr = pictureId
        if pictureId == 0 {
            pimmelNr = Int.random(in: 1...K.pimmelAnzahl)
        }
        
        
        
        imageView.image = UIImage(named: pictureName + String(pimmelNr))
        
        paintView.addSubview(imageView)
        
        isTouching = true
        rotateViewWhileTouch(imageView, by: angleIncrement)
     }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouching = false
    }
    
    func rotateViewWhileTouch(_ viewForRotation: UIView, by angle: CGFloat){
        let rotation = CGAffineTransform(rotationAngle: angle)
        UIView.animate(withDuration: timeForAnimation) {
            viewForRotation.transform = rotation
        } completion: { _ in
            if self.isTouching {
                self.rotateViewWhileTouch(viewForRotation, by: angle + self.angleIncrement)
            }
        }

    }
    
    func autoSlider(){
        if sizeSlider.value == 100 {sliderMovement = .down}
        if sizeSlider.value == 0 {sliderMovement = .up}
        
//        if randomSize {
            switch sliderMovement {
                case .up: sizeSlider.value += 1
                case .down: sizeSlider.value -= 1
            }
//        }
//        print(sizeSlider.value)
        setSizeLabel()
    }
    
    func setSizeLabel(){
        sizeLabel.text = String(format: "%.0F", sizeSlider.value) + " %"
        sizeLabel.setNeedsLayout()
    }
    
    func startTimer() {
        let queue = DispatchQueue.main
        sliderTimer = DispatchSource.makeTimerSource(queue: queue)
        sliderTimer!.schedule(deadline: .now(), repeating: .milliseconds(sliderSpeed*10))
        sliderTimer!.setEventHandler {
            self.autoSlider()
        }
        
        sliderTimer!.resume()
    }

    func stopTimer() {
        sliderTimer?.cancel()
        sliderTimer = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "SelectSegue":
            if let newController = segue.destination as? PimmelAuswahlController {
            newController.delegate = self
            }
        
        default: break
        }
    }

}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}
