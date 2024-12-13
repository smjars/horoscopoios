//
//  HoroscopeViewCell.swift
//  HoroscopoIOS
//
//  Created by Tardes on 12/12/24.
/*Esta clase fue creada dando click derecho en la carpeta principal HoroscopoIOS(new file from template y seleccionando cocoa touch) ya que es una clase
 que hereda de una de IOS, en este caso esta sera la clase encargada de determinar lo que le pasa a TableView y por esa razon permite poder arrastrar
 la celda a esta clase y poder modificarla*/

import UIKit
/* desde el main view controles, dentro de la Table View, seleccionar la celda y en el inspector identity, en el apartado Class seleccionar esta clase para
 (HoroscopeViewCell)*/
class HoroscopeViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Crear una vista de fondo para la selección
                let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemPink // Cambia el color aquí
                self.selectedBackgroundView = selectedBackgroundView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render(from horoscopo: Horoscopo){
        nameLabel.text = horoscopo.name;
        iconImageView.image = horoscopo.icon;
        datesLabel.text = horoscopo.dates
    }
}
