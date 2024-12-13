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
    let horoscopoList: [Horoscopo] = Horoscopo.getAll()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //este codigo fue utilizado para hcer la importacion del tableView que se agrego en esta clase principal y las 2 funciones que manejan la tableView.
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //para retornar la cantidad de horoscopos que hay(rows).
        return Horoscopo.getAll().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // la variable cell será igual a la celda con el nombre "cell" que se pasa como identificador y se dice que sera del tipo HoroscopeViewCell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HoroscopeViewCell
        // se asigna cada fila (cada horoscopo)a la variable horoscopo.
        let horoscopo = horoscopoList[indexPath.row]
        // se renderiza cada fila que contiene la variable horoscopo.
        cell.render(from: horoscopo)
        //se devuelve la variable cell con todas las celdas.
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "navigate2"){
            let detailViewController = segue.destination as! DetailController
            let indexPath = tableView.indexPathForSelectedRow!
            let horocopo = horoscopoList[indexPath.row]
            detailViewController.horoscopo = horocopo
            
            //esto es para desseleccionar la selda y no quede seleccionada al volver
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

