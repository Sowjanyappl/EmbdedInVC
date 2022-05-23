//
//  ViewController.swift
//  SampleVCApp
//
//  Created by Sowjanya Chavala on 09/05/22.
//

import UIKit
import WebKit
import SafariServices
class ViewController: UIViewController , WKNavigationDelegate, SFSafariViewControllerDelegate{
    private var webView: WKWebView!
    public var roomUrlString = "https://app.invc.vc/" // Replace by your own

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 14.5, *) {
            // Use WKWebView
            loadInHeigherVersionWebView()

        } else if #available(iOS 14.3, *) {
            // Use SFSafariViewController
            loadInSafariVC()
        } else {
            // Redirect to browser app
            openUrl()
        }
    }
    func loadInHeigherVersionWebView(){
        let config = WKWebViewConfiguration()
                config.allowsInlineMediaPlayback = true
                webView = WKWebView(frame: view.frame, configuration: config)
                webView.navigationDelegate = self
                view = webView
                guard let roomUrl = URL(string: roomUrlString) else {
                    return
                }
                webView.load(URLRequest(url: roomUrl))
    }
    func loadInSafariVC() {
        guard let roomUrl = URL(string: roomUrlString) else {
                   return
               }
               let safariVC = SFSafariViewController(url: roomUrl)
               safariVC.delegate = self
               present(safariVC, animated: true)
    }
    
    func openUrl(){
        guard let roomUrl = URL(string: roomUrlString),
              UIApplication.shared.canOpenURL(roomUrl) else {
                  return
              }
        UIApplication.shared.open(roomUrl)
        
    }


}

