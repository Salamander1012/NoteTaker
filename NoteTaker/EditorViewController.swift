//
//  EditorViewController.swift
//  NoteTaker
//
//  Created by Salman Fakhri on 2/22/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit
import WebKit

class EditorViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var toolBar: UIView!
    
    var toolBarBottomConstraint: NSLayoutConstraint?
    var webviewConstraints: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        toolBarBottomConstraint = NSLayoutConstraint(item: toolBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        webviewConstraints = NSLayoutConstraint(item: webview, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        if let path = Bundle.main.path(forResource: "index", ofType: "html") {
            let url = URL(fileURLWithPath: path)
            let urlRequest = URLRequest(url: url)
            webview.load(urlRequest)
            
        }
        
        
        view.addConstraint(toolBarBottomConstraint!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
//        webview.contentMode = .scaleToFill
//        webview.scrollView.bounces = false
//        webview.scrollView.layer.masksToBounds = false
//
        toolBar.addTopBorderWithColor(color: UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0), width: 1)
        

    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
            //print(keyboardFrame)
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            toolBarBottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            webviewConstraints?.constant = isKeyboardShowing ? -keyboardFrame!.height - 30 : 0
            webview.scrollView.setNeedsFocusUpdate()
            webview.contentMode = .scaleToFill
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: {(completed) in })
        }
        
    }
    
    @IBAction func listPressed(_ sender: Any) {
        webview.evaluateJavaScript("document.execCommand(\"insertUnorderedList\", false, null)") { (asd, error) in
            print("insert list")
        }
    }
    
    @IBAction func h1Pressed(_ sender: Any) {
        webview.evaluateJavaScript("document.execCommand(\"formatBlock\", false, \"H1\")") { (asd, error) in
            print("insert H1")
        }
        
    }
    
    @IBAction func h2Pressed(_ sender: Any) {
        webview.evaluateJavaScript("document.execCommand(\"formatBlock\", false, \"H2\")") { (asd, error) in
            print("insert H2")
        }
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

extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
}
