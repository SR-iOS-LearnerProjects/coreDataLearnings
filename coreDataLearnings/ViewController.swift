//
//  ViewController.swift
//  coreDataLearnings
//
//  Created by Sridatta Nallamilli on 20/02/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var fnameErrLbl: UILabel!
    @IBOutlet weak var lnameErrLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var addImgBtn: UIButton!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fnameTF.layer.cornerRadius = fnameTF.frame.height / 2.0
        lnameTF.layer.cornerRadius = lnameTF.frame.height / 2.0
        saveBtn.layer.cornerRadius = 4
        
        fnameTF.delegate = self
        lnameTF.delegate = self
        self.profileImg.layer.cornerRadius = self.profileImg.frame.height / 2.0
        
        fnameErrLbl.isHidden = true
        lnameErrLbl.isHidden = true
        
        let tap = UIGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }

    @IBAction func addImgBtnTapped(_ sender: UIButton) {
        print("Add Image Button Tapped.")
        
        let actionSheet = UIAlertController(
            title: "Choose from below",
            message: "",
            preferredStyle: UIAlertController.Style.actionSheet
        )
        
        actionSheet.addAction(UIAlertAction.init(title: "Files", style: UIAlertAction.Style.default, handler: { (action) in
            let documentPicker = UIDocumentPickerViewController(documentTypes: [(kUTTypeJPEG as String)], in: UIDocumentPickerMode.import)
            
            documentPicker.delegate = self
            
            if #available(iOS 11.0, *) {
                documentPicker.allowsMultipleSelection = false
            } else {
                let alert = UIAlertController(title: "Not Supported", message: "iOS version should be 11.0 and above.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.destructive, handler: { (action) in
                    //
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            self.present(documentPicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction.init(
            title: "Camera",
            style: UIAlertAction.Style.default,
            handler: { (action) in
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized {
                self.imagePicker.sourceType = .camera
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            else {
                AVCaptureDevice.requestAccess(for: .video) { (granted) in
                    if granted {
                        self.imagePicker.sourceType = .camera
                        self.present(self.imagePicker, animated: true, completion: nil)
                    }
                    else {
                        self.alertCameraAccessNeeded()
                    }
                }
            }
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Photo Library", style: UIAlertAction.Style.default, handler: { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.destructive, handler: { (action) in
            //
        }))
        
        self.present(actionSheet, animated: true, completion: nil)

    }
    
    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
     
         let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to perform this action.",
            preferredStyle: UIAlertController.Style.alert
         )
     
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
    
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        //getting values from textfields
        let firstName = self.fnameTF.text
        let lastName = self.lnameTF.text
       
        if firstName!.isEmpty {
            print("Please enter firstname")
            fnameErrLbl.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.fnameErrLbl.isHidden = true
            }
//            UIView.animate(withDuration: 3) {
//                self.fnameErrLbl.alpha = 0
//            }
        }
        else if lastName!.isEmpty {
            print("Please enter lastname")
            lnameErrLbl.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.lnameErrLbl.isHidden = true
            }
        }
        else {
            let fullName = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
            fullName.setValue(firstName, forKey: "firstname")
            fullName.setValue(lastName, forKey: "lastname")
            
            do {
                try context.save()
                self.fnameTF.text = "" 
                self.lnameTF.text = ""
            }
            catch {
                print("Error")
            }
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "InfoVC") as? InfoViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImg.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFileURL = urls.first else { return }
                
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            do {
                try FileManager.default.replaceItemAt(selectedFileURL, withItemAt: sandboxFileURL)
                print("File Import Successful")
            } catch {
                print("Error")
            }
        }
        else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                print("File Import Successful")
            }
            catch {
                print("Error: \(error)")
            }
        }
    }
}
