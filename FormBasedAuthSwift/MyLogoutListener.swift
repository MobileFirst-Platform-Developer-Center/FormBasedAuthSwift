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

class MyLogoutListener: NSObject, WLDelegate {
    
    var vc : ViewController
    
    init(vc: ViewController){
        self.vc = vc
    }
    
    func onSuccess(response: WLResponse!) {
        NSLog("Logout Succeeded")
        var adapterResponseAlert = UIAlertController(title: "Logout Succeeded",
                                                    message: response.responseText,
                                                    preferredStyle: .Alert)
        adapterResponseAlert.addAction(UIAlertAction(title: "OK",
                                                    style: .Default,
                                                    handler: nil))
        vc.presentViewController(adapterResponseAlert,
                                animated: true,
                                completion: nil)
        
    }
    
    func onFailure(response: WLFailResponse!) {
        NSLog("Logout Failed")
        var adapterResponseAlert = UIAlertController(title: "Logout Failed",
                                                    message: response.errorMsg,
                                                    preferredStyle: .Alert)
        adapterResponseAlert.addAction(UIAlertAction(title: "OK",
                                                    style: .Default,
                                                    handler: nil))
        vc.presentViewController(adapterResponseAlert,
                                animated: true,
                                completion: nil)
    }
}
