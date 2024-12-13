//
//  ViewController.swift
//  HoroscopoIOS
//
//  Created by Tardes on 12/12/24.
// Le he cambiado el nombre a MainViewController para saber queb este controlador es el main(Editir Refactor).

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    //se trae el elemento table view desde el MAIN.
    @IBOutlet weak var tableView: UITableView!
    //se declara la variable que contendra la lista desde el archivo Horoscopo que tiene la struct con los datos del horoscopo en la funcion getAll.
    var horoscopoList: [Horoscopo] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //este codigo fue utilizado para hcer la importacion del tableView que se agrego en esta clase principal y las 2 funciones que manejan la tableView.
        tableView.dataSource = self
        
        Horoscopo.fetchAll { [weak self] horoscopos in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        if let horoscopos = horoscopos {
                            self.horoscopoList = horoscopos
                            self.tableView.reloadData()
                        }
                    }
                }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return horoscopoList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HoroscopeViewCell
            let horoscopo = horoscopoList[indexPath.row]
            cell.render(from: horoscopo)
            return cell
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "navigate2" {
                let detailViewController = segue.destination as! DetailController
                let indexPath = tableView.indexPathForSelectedRow!
                let horoscopo = horoscopoList[indexPath.row]
                detailViewController.horoscopo = horoscopo
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }

