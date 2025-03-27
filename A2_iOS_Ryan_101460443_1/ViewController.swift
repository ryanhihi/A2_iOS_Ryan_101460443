//
//  ViewController.swift
//  A2_iOS_Ryan_101460443_1
//
//  Created by Christian Aiden on 2025-03-27.
//

import UIKit
import CoreData

class ViewController: UIViewController, UISearchBarDelegate{

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
        
        // Configure search bar
        searchBar.delegate = self
        
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
    
    // UISearchBarDelegate method for search functionality
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredProducts = products
            } else {
                filteredProducts = products?.filter { product in
                    let nameMatch = product.name?.lowercased().contains(searchText.lowercased()) ?? false
                    let descriptionMatch = product.desc?.lowercased().contains(searchText.lowercased()) ?? false
                    return nameMatch || descriptionMatch
                }
            }
            
            // Display the first filtered product
            displayFirstProduct()
        }
    
    //Prepare for the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowProductListSegue" {
            if let productListVC = segue.destination as? ProductListTableViewController {
                productListVC.products = self.products
            }
        }
    }


}

