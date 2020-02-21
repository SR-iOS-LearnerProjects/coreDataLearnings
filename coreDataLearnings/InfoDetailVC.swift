//
//  InfoDetailVC.swift
//  coreDataLearnings
//
//  Created by Sridatta Nallamilli on 21/02/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class InfoDetailVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var proImg: UIImageView!
    @IBOutlet weak var fNameLbl: UILabel!
    @IBOutlet weak var lNameLbl: UILabel!
    
    var fName = ""
    var lName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fNameLbl.text = fName
        lNameLbl.text = lName
        
    }
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
