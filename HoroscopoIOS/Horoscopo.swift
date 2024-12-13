//
//  Horoscopo.swift
//  HoroscopoIOS
//
//  Created by Tardes on 12/12/24.
//Esta struct fue creada dando click derecho en la carpeta principal HoroscopoIOS(new file from template y seleccionando Swift file) ya que es independiente

import Foundation
import UIKit

struct Horoscopo {
    
    let id: String
    let name: String
    let icon: UIImage
    let dates: String
    
    static func getAll() -> [Horoscopo] {
        return [
                    Horoscopo(id: "aries", name: "Aries", icon: UIImage(named: "horoscopo-icons/aries")!, dates: "March 21 to April 19"),
                    Horoscopo(id: "taurus", name: "Taurus", icon: UIImage(named: "horoscopo-icons/taurus")!, dates: "April 20 to May 20"),
                    Horoscopo(id: "gemini", name: "Gemini", icon: UIImage(named: "horoscopo-icons/gemini")!, dates: "May 21 to June 20"),
                    Horoscopo(id: "cancer", name: "Cancer", icon: UIImage(named: "horoscopo-icons/cancer")!, dates: "June 21 to July 22"),
                    Horoscopo(id: "leo", name: "Leo", icon: UIImage(named: "horoscopo-icons/leo")!, dates: "July 23 to August 22"),
                    Horoscopo(id: "virgo", name: "Virgo", icon: UIImage(named: "horoscopo-icons/virgo")!, dates: "August 23 to September 22"),
                    Horoscopo(id: "libra", name: "Libra", icon: UIImage(named: "horoscopo-icons/libra")!, dates: "September 23 to October 22"),
                    Horoscopo(id: "scorpio", name: "Scorpio", icon: UIImage(named: "horoscopo-icons/scorpio")!, dates: "October 23 to November 21"),
                    Horoscopo(id: "sagittarius", name: "Sagittarius", icon: UIImage(named: "horoscopo-icons/sagittarius")!, dates: "November 22 to December 21"),
                    Horoscopo(id: "capricorn", name: "Capricorn", icon: UIImage(named: "horoscopo-icons/capricorn")!, dates: "December 22 to January 19"),
                    Horoscopo(id: "aquarius", name: "Aquarius", icon: UIImage(named: "horoscopo-icons/aquarius")!, dates: "January 20 to February 18"),
                    Horoscopo(id: "pisces", name: "Pisces", icon: UIImage(named: "horoscopo-icons/pisces")!, dates: "February 19 to March 20")
                ]
    }
    
}
