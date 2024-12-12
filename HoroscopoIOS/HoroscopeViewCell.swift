//
//  HoroscopeViewCell.swift
//  HoroscopoIOS
//
//  Created by Tardes on 12/12/24.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
