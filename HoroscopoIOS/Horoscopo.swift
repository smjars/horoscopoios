//
//  Horoscopo.swift
//  HoroscopoIOS
//
//  Created by Tardes on 12/12/24.
//Esta struct fue creada dando click derecho en la carpeta principal HoroscopoIOS(new file from template y seleccionando Swift file) ya que es independiente
    
    // Estructura que representa un horóscopo
import Foundation
import UIKit

struct Horoscopo: Codable {
    let id: String // Identificador del horóscopo
    let name: String // Nombre del horóscopo
    let icon: UIImage // Icono del horóscopo
    let date: String // Fecha del horóscopo
    let horoscopeData: String // Datos del horóscopo

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case icon
        case date
        case horoscopeData
    }

    init(id: String, name: String, icon: UIImage, date: String, horoscopeData: String) {
        self.id = id
        self.name = name
        self.icon = icon
        self.date = date
        self.horoscopeData = horoscopeData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        date = try container.decode(String.self, forKey: .date)
        horoscopeData = try container.decode(String.self, forKey: .horoscopeData)
        let iconData = try container.decode(Data.self, forKey: .icon)
        guard let icon = UIImage(data: iconData) else {
            throw DecodingError.dataCorruptedError(forKey: .icon, in: container, debugDescription: "Icon image data is corrupted")
        }
        self.icon = icon
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(horoscopeData, forKey: .horoscopeData)
        guard let iconData = icon.pngData() else {
            throw EncodingError.invalidValue(icon, EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Unable to convert UIImage to Data"))
        }
        try container.encode(iconData, forKey: .icon)
    }

    static func fetchAll(completion: @escaping ([Horoscopo]?) -> Void) {
        let signs = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
        var horoscopos: [Horoscopo] = []
        let group = DispatchGroup()

        for sign in signs {
            group.enter()
            let urlString = "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=\(sign)&day=TODAY"
            guard let url = URL(string: urlString) else {
                group.leave()
                continue
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { group.leave() }
                if let error = error {
                    print("Error fetching data: \(error)")
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    if apiResponse.status == 200, apiResponse.success {
                        let horoscopo = Horoscopo(
                            id: sign.lowercased(),
                            name: sign,
                            icon: UIImage(named: "horoscopo-icons/\(sign.lowercased())")!,
                            date: apiResponse.data.date,
                            horoscopeData: apiResponse.data.horoscopeData
                        )
                        horoscopos.append(horoscopo)
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }.resume()
        }

        group.notify(queue: .main) {
            completion(horoscopos)
        }
    }
}
