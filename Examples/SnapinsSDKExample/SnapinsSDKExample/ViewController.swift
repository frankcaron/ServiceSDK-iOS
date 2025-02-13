//
//  ViewController.swift
//  SnapinsSDKExample
//

import UIKit
import WebKit



import ServiceCore
import ServiceKnowledge
import ServiceCases
import ServiceChat
import ServiceSOS

class ViewController: UIViewController, WKUIDelegate {
    
  var webView: WKWebView!
    
  override func loadView() {
    super.loadView()
      
  }

  @IBOutlet weak var knowledgeButton: UIButton!
  @IBOutlet weak var casesButton: UIButton!
  @IBOutlet weak var chatButton: UIButton!

  var customActionButton: SCSActionButton?

  /**
   Determines whether any Snap-ins features are enabled.
   */
  let somethingIsEnabled = SnapinsConstants.ENABLE_KNOWLEDGE ||
    SnapinsConstants.ENABLE_CASES ||
    SnapinsConstants.ENABLE_CHAT
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Enable the relevant Snap-ins buttons and labels
    knowledgeButton.isHidden = !SnapinsConstants.ENABLE_KNOWLEDGE
    casesButton.isHidden = !SnapinsConstants.ENABLE_CASES
    chatButton.isHidden = !SnapinsConstants.ENABLE_CHAT
    
      let webConfiguration = WKWebViewConfiguration()
      //webView = WKWebView(frame: .zero, configuration: webConfiguration)
      webView = WKWebView(frame: .zero, configuration: webConfiguration)
      //  webView = WKWebView()
      webView.frame  = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-50)
      webView.layer.zPosition = -1
      webView.uiDelegate = self
    
      let myURL = URL(string:"https://shop.lululemon.com")
      let myRequest = URLRequest(url: myURL!)
      webView.load(myRequest)
    
      self.view.addSubview(webView)
  }

  /**
   Starts Knowledge.
   */
    @IBAction func startKnowledge(_ sender: AnyObject) {
    ServiceCloud.shared().knowledge.setInterfaceVisible(true,
      animated: true, completion: nil)
  }
  
  /**
   Starts Case Management.
   */
  @IBAction func startCases(_ sender: Any) {
    ServiceCloud.shared().cases.setInterfaceVisible(true,
      animated: true, completion: nil)
  }

  /**
   Starts Live Agent Chat.
   */
    
    @IBAction func startChat(_ sender: Any) {
    
    ServiceCloud.shared().chatUI.showChat(with: SnapinsConfig.instance.chatConfig!,
                                          showPrechat: SnapinsConstants.ENABLE_PRECHAT_FIELDS)
    
    // Use this command instead of above if you never need to show a pre-chat form...
    // ServiceCloud.shared().chatUI.showChat(with: SnapinsConfig.instance.chatConfig!)
  }

}

