//
//  AddProductViewController.swift
//  A2_iOS_Ryan_101460443_1
//
//  Created by Christian Aiden on 2025-03-27.
//

import UIKit
import CoreData

class AddProductViewController: UIViewController {
    
    // add global context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var saveProduct: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func saveNewProduct(_ sender: UIButton) {
        
        guard let name = textFields[0].text, !name.isEmpty,
            let description = textFields[1].text, !description.isEmpty,
            let priceText = textFields[2].text, let price = Double(priceText),
              let provider = textFields[3].text, !provider.isEmpty else {
            showAlert("Error", "Please fill in all fields correctly.")
            return
        }
        
        // Create a new Product
                let newProduct = Product(context: context)
                newProduct.productID = UUID()
                newProduct.name = name
                newProduct.desc = description
                newProduct.price = price
                newProduct.provider = provider
        
        do {
                    try context.save()
                    showAlert("Success", "Product saved successfully.") { [weak self] in
                        self?.clearFields()
                    }
                } catch {
                    showAlert("Error", "Failed to save product: \(error.localizedDescription)")
                }
    }
    
    private func clearFields() {
        textFields[0].text = ""
        textFields[1].text = ""
        textFields[2].text = ""
        textFields[3].text = ""
        }
    
    
    
}
