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
        
        //load product data
        loadProducts()
        displayFirstProduct()
    }

    //function to load data
    func loadProducts() {
        
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            products = try context.fetch(fetchRequest)
            filteredProducts = products
            
        } catch {
            print("error fetching data: \(error.localizedDescription)" )
        }
    }
    
    //Load the first product in the inventory on screen
    func displayFirstProduct(){
        guard let firstProduct = filteredProducts?.first else {
            // In case no products available
            productIdLabel.text = "No Products Available"
            productNameLabel.text = ""
            descriptionLabel.text = ""
            priceLabel.text = ""
            providerLabel.text = ""
            return
        }
        
        // Update labels with product details
        productIdLabel.text = "ID: \(firstProduct.productID?.uuidString ?? "N/A")"
        productNameLabel.text = "Name: \(firstProduct.name ?? "N/A")"
        descriptionLabel.text = "Description: \(firstProduct.desc ?? "N/A")"
        priceLabel.text = "Price: $\(firstProduct.price)"
        providerLabel.text = "Provider: \(firstProduct.provider ?? "N/A")"
    }
    
    

}

