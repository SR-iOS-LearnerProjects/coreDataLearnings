//
//  InfoViewController.swift
//  coreDataLearnings
//
//  Created by Sridatta Nallamilli on 20/02/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import CoreData

class InfoViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet var infoTableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    let fnameArr = ["One","Two"]
    let lnameArr = ["One Lastname","Two Lastname"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infoTableView.reloadData()
    }
  
    @IBAction func addBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fnameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoTableView.dequeueReusableCell(withIdentifier: "cell") as! InfoTableViewCell
        cell.fnameLbl.text = fnameArr[indexPath.row]
        cell.lnameLbl.text = lnameArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(identifier: "InfoDVC") as! InfoDetailVC
        vc.fName = fnameArr[indexPath.row]
        vc.lName = lnameArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
