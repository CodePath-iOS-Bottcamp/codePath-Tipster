//
//  Default.swift
//  Tipster
//
//  Created by Arthur Burgin on 2/13/17.
//  Copyright © 2017 Arthur Burgin. All rights reserved.
//

import Foundation
struct Default{
    let myDefault = UserDefaults.standard
    let key: String
    
    func saveValue(_ val: Any){
        myDefault.set(val, forKey: key)
        myDefault.synchronize()
    }
    
    func returnValue()->Any?{
        return myDefault.object(forKey: key)
    }
}
