//
//  ViewController.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 23.10.2023.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var yemeklerListesi = [Yemekler]()
    var viewModel = HomeViewModel()
    var selectedFood: Yemekler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        appearence()
        
        _ = viewModel.yemeklerListesi.subscribe(onNext: { liste in
            self.yemeklerListesi = liste
            DispatchQueue.main.async { //asenkron bir şekilde çalışmamızı sağlar
                self.collectionView.reloadData()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.yemekleriYukle()
    }
}

extension HomeViewController {
    
    func appearence(){
        self.navigationItem.title = "fastFood"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "anaRenk")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "yaziRenk")!, .font: UIFont(name: "Kanit-SemiBoldItalic", size: 22)!]
        
        
        self.navigationItem.compactAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        
        let genislik = UIScreen.main.bounds.width
        let itemGenislik = (genislik - 50) / 2
        collectionViewLayout.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.6)
        collectionView.collectionViewLayout = collectionViewLayout
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        cell.foodImageView.kf.setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemeklerListesi[indexPath.item].yemek_resim_adi!)"))
        cell.foodLabel.text = yemeklerListesi[indexPath.item].yemek_adi!
        cell.priceLabel.text = "\(yemeklerListesi[indexPath.item].yemek_fiyat!) ₺"
        return  cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.chooseFood = self.selectedFood
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedFood = yemeklerListesi[indexPath.item]
        performSegue(withIdentifier: "goToDetail", sender: nil)
    }
}
