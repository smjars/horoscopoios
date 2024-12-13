//
//  Horoscopo.swift
//  HoroscopoIOS
//
//  Created by Tardes on 12/12/24.
//Esta struct fue creada dando click derecho en la carpeta principal HoroscopoIOS(new file from template y seleccionando Swift file) ya que es independiente

import Foundation
import UIKit

/* Aqui traigo los horoscopos desde local.
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
    
}*/
import Foundation
import UIKit

// Estructura que representa un horóscopo
struct Horoscopo {
    let id: String // Identificador del horóscopo
    let name: String // Nombre del horóscopo
    let icon: UIImage // Icono del horóscopo
    let date: String // Fecha del horóscopo
    let horoscopeData: String // Datos del horóscopo

    // Método estático para obtener todos los horóscopos
    static func fetchAll(completion: @escaping ([Horoscopo]?) -> Void) {
        // Lista de signos del zodiaco
        let signs = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
        // Array para almacenar los horóscopos
        var horoscopos: [Horoscopo] = []
        
        // Grupo de tareas para gestionar las solicitudes de red
        let group = DispatchGroup()
        
        // Iterar sobre cada signo del zodiaco
        for sign in signs {
            group.enter() // Entrar en el grupo de tareas
            let urlString = "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?sign=\(sign)&day=TODAY"
            guard let url = URL(string: urlString) else {
                group.leave() // Salir del grupo de tareas si la URL no es válida
                continue
            }

            // Realizar la solicitud de datos
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { group.leave() } // Asegurarse de salir del grupo de tareas al finalizar
                if let error = error {
                    print("Error fetching data: \(error)") // Imprimir el error si ocurre
                    return
                }

                guard let data = data else {
                    return // Salir si no se recibe ningún dato
                }

                do {
                    // Decodificar los datos de la respuesta de la API
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    if apiResponse.status == 200, apiResponse.success {
                        // Crear una instancia de Horoscopo y añadirla al array
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
                    print("Error decoding data: \(error)") // Imprimir el error si ocurre durante la decodificación
                }
            }.resume() // Iniciar la tarea de URLSession
        }
        
        // Notificar cuando todas las tareas hayan finalizado
        group.notify(queue: .main) {
            completion(horoscopos) // Llamar al bloque de finalización con los horóscopos obtenidos
        }
    }
}
