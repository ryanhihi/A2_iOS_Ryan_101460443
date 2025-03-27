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
    
    
    @IBAction func saveNewProduct(_ sender: Any) {
    }
    
}
