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
import Foundation
import IBMMobileFirstPlatformFoundation

class MyChallengeHandler: ChallengeHandler {
    
    let vc : ViewController
    
    init(vc: ViewController){
        self.vc = vc
        super.init(realm: "SampleAppRealm")
    }
    
    override func isCustomResponse(response: WLResponse!) -> Bool {
        if response != nil && response.responseText != nil{
            if response.responseText.lowercaseString.rangeOfString("j_security_check") != nil{
                NSLog("Detected j_security_check string - returns true")
                return true
            }
        }
        return false
    }
    
    override func handleChallenge(response: WLResponse!) {
        NSLog("A login form should appear")
        if self.vc.navigationController?.visibleViewController!.isKindOfClass(LoginViewController) == true {
            dispatch_async(dispatch_get_main_queue()) {
                let loginController : LoginViewController! = self.vc.navigationController?.visibleViewController as? LoginViewController
                loginController.errorMsg.hidden = false
            }
        } else {
            self.vc.performSegueWithIdentifier("showLogin", sender: self.vc)
            dispatch_async(dispatch_get_main_queue()) {
                let loginController : LoginViewController! = self.vc.navigationController?.visibleViewController as? LoginViewController
                loginController.challengeHandler = self
                loginController.errorMsg.hidden = true
            }
        }
    }
    
    override func onSuccess(response: WLResponse!) {
        NSLog("Challenge succeeded")
        self.vc.navigationController?.popViewControllerAnimated(true)
        self.submitSuccess(response)
    }
    
    override func onFailure(response: WLFailResponse!) {
        NSLog("Challenge failed")
        self.submitFailure(response)
    }
    
}
