//
//  CreatetionViewController.swift
//  NoteTaker
//
//  Created by Salman Fakhri on 2/20/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

class CreatetionViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var createNoteView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNoteView.layer.shadowOpacity = 0.4
        self.createNoteView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.createNoteView.layer.shadowRadius = 7.0
        self.createNoteView.layer.shadowColor = UIColor.lightGray.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
        tap.delegate = self
        createNoteView.addGestureRecognizer(tap)
        
        
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        print("printing")
        performSegue(withIdentifier: "showEditor", sender: self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
