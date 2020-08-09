///  Created by `___FULLUSERNAME___` on ___DATE___.

import MVVMRExtensions

struct ___VARIABLE_sceneIdentifier___Rout {
    
    
    
}

extension ___VARIABLE_sceneIdentifier___Rout: RoutType {
    static var registerPattern: String {
        
        return "<#Scheme#>://___VARIABLE_sceneIdentifier___".lowercased()
    }
    
    var scheme: String { <#Scheme#>.lowercased() }
    
    var host: String { "___VARIABLE_sceneIdentifier___".lowercased() }
}
