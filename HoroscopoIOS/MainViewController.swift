//
//  ViewController.swift
//  HoroscopoIOS
//
//  Created by Tardes on 12/12/24.
// Le he cambiado el nombre a MainViewController para saber queb este controlador es el main(Editir Refactor).

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    //se trae el elemento table view desde el MAIN.
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar! // Añadir IBOutlet para la barra de búsqueda
    //se declara la variable que contendra la lista desde el archivo Horoscopo que tiene la struct con los datos del horoscopo en la funcion getAll.
    var horoscopoList: [Horoscopo] = [];
    // para almacenar si favorito esta seleccionado.//
    var filteredHoroscopoList: [Horoscopo] = [] // Lista filtrada
    var favoriteHoroscopos: [Horoscopo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //este codigo fue utilizado para hcer la importacion del tableView que se agrego en esta clase principal y las 2 funciones que manejan la tableView.
        tableView.dataSource = self
        searchBar.delegate = self // Asignar delegado de la barra de búsqueda
        loadFavorites()
        
        Horoscopo.fetchAll { [weak self] horoscopos in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let horoscopos = horoscopos {
                    self.horoscopoList = horoscopos
                    self.filteredHoroscopoList = horoscopos // Inicializar lista filtrada
                    self.reloadTableView()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHoroscopoList.count // Usar la lista filtrada
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HoroscopeViewCell
        let horoscopo = filteredHoroscopoList[indexPath.row] // Usar la lista filtrada
        let isFavorite = favoriteHoroscopos.contains { $0.id == horoscopo.id }
        cell.render(from: horoscopo, isFavorite: isFavorite)
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        cell.favoriteButton.tag = indexPath.row
        return cell
    }
    
    /*@objc func favoriteButtonTapped(_ sender: UIButton) {
        let horoscopo = horoscopoList[sender.tag]
        toggleFavorite(horoscopo: horoscopo)
    }*/
    @objc func favoriteButtonTapped(_ sender: UIButton) {
            let index = sender.tag
        let horoscopo = filteredHoroscopoList[index] // Usar la lista filtrada
            
            toggleFavorite(horoscopo: horoscopo)
            
            // Scroll to the top of the table view after updating the favorites
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navigate2" {
            let detailViewController = segue.destination as! DetailController
            let indexPath = tableView.indexPathForSelectedRow!
            let horoscopo = filteredHoroscopoList[indexPath.row] // Usar la lista filtrada
            detailViewController.horoscopo = horoscopo
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // funciones para manejar favoritos y persistirlos//
    func toggleFavorite(horoscopo: Horoscopo) {
        if let index = favoriteHoroscopos.firstIndex(where: { $0.id == horoscopo.id }) {
            favoriteHoroscopos.remove(at: index)
        } else {
            favoriteHoroscopos.append(horoscopo)
        }
        saveFavorites()
        reloadTableView()
    }
    
    func reloadTableView() {
        horoscopoList.sort { (first, second) -> Bool in
            let isFirstFavorite = favoriteHoroscopos.contains { $0.id == first.id }
            let isSecondFavorite = favoriteHoroscopos.contains { $0.id == second.id }
            if isFirstFavorite && !isSecondFavorite {
                return true
            } else if !isFirstFavorite && isSecondFavorite {
                return false
            } else {
                return false // or any other sorting logic you prefer when both are either favorite or not favorite
            }
        }
        // Actualizar filteredHoroscopoList después de ordenar horoscopoList
            if let searchText = searchBar.text, !searchText.isEmpty {
                filteredHoroscopoList = horoscopoList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            } else {
                filteredHoroscopoList = horoscopoList
            }
            tableView.reloadData()
    }
    
    func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favoriteHoroscopos"),
           let favorites = try? JSONDecoder().decode([Horoscopo].self, from: data) {
            favoriteHoroscopos = favorites
        }
    }

    func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteHoroscopos) {
            UserDefaults.standard.set(data, forKey: "favoriteHoroscopos")
        }
    }
    // Implementación del delegado de la barra de búsqueda
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredHoroscopoList = horoscopoList
            } else {
                filteredHoroscopoList = horoscopoList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            }
            tableView.reloadData()
        }
}
