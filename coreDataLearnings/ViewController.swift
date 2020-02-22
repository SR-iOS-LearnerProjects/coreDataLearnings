//
//  ViewController.swift
//  coreDataLearnings
//
//  Created by Sridatta Nallamilli on 20/02/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fnameTF.layer.cornerRadius = fnameTF.frame.height / 2.0
        lnameTF.layer.cornerRadius = lnameTF.frame.height / 2.0
        saveBtn.layer.cornerRadius = 4
        
    }

    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        //getting values from textfields
        let firstName = fnameTF.text
        let lastName = lnameTF.text
        
        let fullName = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        fullName.setValue(firstName, forKey: "firstname")
        fullName.setValue(lastName, forKey: "lastname")
        
        do {
            try context.save()
            fnameTF.text = ""
            lnameTF.text = ""
        }
        catch {
            print("Error")
        }
        
        let vc = self.storyboard?.instantiateViewController(identifier: "InfoVC") as! InfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

