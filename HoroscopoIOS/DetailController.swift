//
//  DetailController.swift
//  HoroscopoIOS
//
//  Created by Tardes on 13/12/24.
//

import UIKit

class DetailController: UIViewController {
    
    var horoscopo: Horoscopo!

    // este fue traido desde la vista con click derecho
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = horoscopo?.name
        iconImageView.image = horoscopo?.icon;
        datesLabel.text = horoscopo.date
        dataLabel.text = horoscopo.horoscopeData
        
        animateImage() // Llama a la función de animación aquí
    }
    
    func animateImage() {
            UIView.animate(withDuration: 1.0,
                           delay: 0,
                           options: [.repeat, .autoreverse],
                           animations: {
                            self.iconImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                           }, completion: nil)
        }
    
    @IBAction func shareOnWhatsApp(_ sender: UIButton) {
            if let horoscopeData = horoscopo?.horoscopeData {
                let urlString = "whatsapp://send?text=\(horoscopeData)"
                if let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                   let url = URL(string: urlStringEncoded) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        print("WhatsApp no está instalado en el dispositivo.")
                    }
                }
            }
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }

}
