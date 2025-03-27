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
    func displayFirstProduct() {
        guard let product = filteredProducts?.first else {
            // No products available
            productIdLabel.text = "No Products Available"
            productNameLabel.text = ""
            descriptionLabel.text = ""
            priceLabel.text = ""
            providerLabel.text = ""
            return
        }

        // Update the labels with the first product's details
        productIdLabel.text = product.productID?.uuidString ?? "N/A"
        productNameLabel.text = product.name ?? "N/A"
        descriptionLabel.text = product.desc ?? "N/A"
        priceLabel.text = String(format: "$%.2f", product.price)
        providerLabel.text = product.provider ?? "N/A"
    }
    
    

    // UISearchBarDelegate method for search functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredProducts = products
                displayFirstProduct()
            } else {
                filteredProducts = products?.filter { product in
                            let nameMatch = product.name?.lowercased().contains(searchText.lowercased()) ?? false
                            let descriptionMatch = product.desc?.lowercased().contains(searchText.lowercased()) ?? false
                            return nameMatch || descriptionMatch
                        }
                }
            
            
            // Display the first filtered product
            displayAllFilteredProducts()
            displayFirstProduct()
        }
    
    //Display all filtered products
    func displayAllFilteredProducts() {
        guard let filteredProducts = filteredProducts, !filteredProducts.isEmpty else {
            // No matching products found
            productIdLabel.text = "No Matching Products"
            productNameLabel.text = ""
            descriptionLabel.text = ""
            priceLabel.text = ""
            providerLabel.text = ""
            return
        }

        if filteredProducts.count == 1 {
            // Display details of a single product
            displayFirstProduct()
        } else {
            // Display details of all filtered products
            let productDetails = filteredProducts.map { product in
                """
                ID: \(product.productID?.uuidString ?? "N/A")
                Name: \(product.name ?? "N/A")
                Description: \(product.desc ?? "N/A")
                Price: \(String(format: "$%.2f", product.price))
                Provider: \(product.provider ?? "N/A")
                """
            }.joined(separator: "\n\n")

            // Assign the concatenated details to the label
            productIdLabel.text = productDetails
            productNameLabel.text = ""
            descriptionLabel.text = ""
            priceLabel.text = ""
            providerLabel.text = ""
        }
    }



}

