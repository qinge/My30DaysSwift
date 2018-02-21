//
//  MyTask.swift
//  Project 07 - PullToRefresh
//
//  Created by qinge on 2018/2/21.
//  Copyright © 2018年 qin. All rights reserved.
//

import Foundation

typealias Task = (_ cancel: Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping () -> ()) -> Task? {
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    var closure: (()->Void)? = task
    
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false){
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    
    return result
}


func cancel(_ task: Task?) {
    task?(true)
}
