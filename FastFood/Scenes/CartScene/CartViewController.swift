//
//  CartViewController.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 26.10.2023.
//

import UIKit
import Kingfisher

class CartViewController: UIViewController {
    
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var toplamFiyat = 0
    var sepetListesi = [SepettekiYemekler]()
    var viewModel = CartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        regulations()
        
        _ = viewModel.sepetListesi.subscribe(onNext: { liste in
            self.sepetListesi = liste
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.updateTotalPrice()
            }
        })
    }
}

extension CartViewController {
    override func viewWillAppear(_ animated: Bool) {
        viewModel.sepetiYukle()
    }
    
    func updateTotalPrice(){
        let totalPriceValue = viewModel.totalPriceCalculation(sepetList: sepetListesi)
        self.totalPrice.text = "\(totalPriceValue) ₺"
    }
    
    func regulations(){
        tableView.dataSource = self
        tableView.delegate = self
        appearance()
    }
    
    func appearance() {
        self.navigationItem.title = "fastFood"
    
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "anaRenk")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "yaziRenk")!, .font: UIFont(name: "Kanit-SemiBoldItalic", size: 22)!]
        
        
        self.navigationItem.compactAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    @IBAction func backButton(_ sender: Any) {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedViewController = tabBarController.viewControllers?.first
        }
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secilenYemek = sepetListesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.setData(secilenYemek: secilenYemek)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction,view,bool in
            let secilen = self.sepetListesi[indexPath.row]
            let alert = UIAlertController(title: "Silme işlemi", message: "\(secilen.yemek_adi!) silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sepetiSil(yemekId: Int(secilen.sepet_yemek_id!)!, kullaniciAdi: secilen.kullanici_adi!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
}
