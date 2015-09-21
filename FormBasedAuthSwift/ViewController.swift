/**
* Copyright 2015 IBM Corp.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import UIKit
import IBMMobileFirstPlatformFoundation

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("Connecting to MobileFirst Server...")
        let connectListener = MyConnectListener()
        WLClient.sharedInstance().registerChallengeHandler(MyChallengeHandler(vc: self))
        WLClient.sharedInstance().wlConnectWithDelegate(connectListener)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func callProtectedAdapterProcedure(sender: AnyObject) {
        let url : NSURL = NSURL(string: "/adapters/AuthAdapter/getSecretData")!
        let request : WLResourceRequest = WLResourceRequest(URL: url, method: WLHttpMethodGet)
        request.sendWithCompletionHandler { (response: WLResponse!, error: NSError!) -> Void in
            if error != nil {
                NSLog("Adapter invocation failure. Error: %@", error.description)
            } else {
                self.alert("Adapter Response", msg: response.responseText)
            }
        }
    }
    
    @IBAction func logout(sender: AnyObject) {
        WLClient.sharedInstance().logout("SampleAppRealm", withDelegate: MyLogoutListener(vc: self))
    }
    
    func alert(alertTitle: String, msg:String){
        if #available (iOS 8.0, *) {
            let alert = UIAlertController(title: alertTitle, message: msg, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK",
                style: .Default,
                handler: nil))
            self.presentViewController(alert,
                animated: true,
                completion: nil)
        } else {
            let alert:UIAlertView = UIAlertView.init(title: alertTitle, message: msg, delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    


}

