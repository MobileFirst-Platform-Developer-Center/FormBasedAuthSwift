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
        vc.alert("Logout Succeeded", msg: response.responseText)
    }
    
    func onFailure(response: WLFailResponse!) {
        NSLog("Logout Failed")
        vc.alert("Logout Failed", msg: response.errorMsg)
    }
}
