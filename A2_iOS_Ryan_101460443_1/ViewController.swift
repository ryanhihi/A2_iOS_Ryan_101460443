//
//  ViewController.swift
//  A2_iOS_Ryan_101460443_1
//
//  Created by Christian Aiden on 2025-03-27.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    //labels to display the first product
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productIdLabel: UILabel!
    
    //Create the global context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //List of products
    var products: [Product]?
    
    //Add filter product for display when search
    var filteredProducts: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //function to load data
    

}

