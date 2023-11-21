//
//  FavoriteViewController.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 23.10.2023.
//

import UIKit
import Kingfisher

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var favorilerListesi = [YemeklerModel]()
    var viewModel = FavoriteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        appearence()
        
        _ = viewModel.favorilerListesi.subscribe(onNext: { liste in
            self.favorilerListesi = liste
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.favorileriYukle()
    }
}

extension FavoriteViewController {
    func appearence(){
        self.navigationItem.title = "fastFood"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "anaRenk")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "yaziRenk")!, .font: UIFont(name: "Kanit-SemiBoldItalic", size: 22)!]
        
        
        self.navigationItem.compactAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
}

extension FavoriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText == "" ? viewModel.favorileriYukle() : viewModel.ara(arananKelime: searchText)
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorilerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
        cell.foodName.text = favorilerListesi[indexPath.row].yemek_adi!
        cell.foodPrice.text = "\(favorilerListesi[indexPath.row].yemek_fiyat!) ₺"
        cell.favoriteImage.kf.setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(favorilerListesi[indexPath.item].yemek_resim_adi!)"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction,view,bool in
            let secilen = self.favorilerListesi[indexPath.row]
            let alert = UIAlertController(title: "Silme işlemi", message: "\(secilen.yemek_adi!) silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sil(yemek: secilen)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
}
