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
                print("执行任务")
                DispatchQueue.main.async(execute: internalClosure)
            }else{
                print("任务被取消")
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
        
        print("3s hou zhixing ")
    }
    
    return result
}


func cancel(_ task: Task?) {
    task?(true)
}
