//
//  ObservableTypeExtension.swift
//  Awesome-List
//
//  Created by PandaMaru on 7/21/2560 BE.
//  Copyright © 2560 amuse. All rights reserved.
//

import RxSwift

extension ObservableType {
    public func subscribeOnBackgroundAndObserveOnMain() -> RxSwift.Observable<Self.E> {
        return self.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)).observeOn(MainScheduler.instance)
    }
    
    public func subscribeOnBackgroundAndObserveOnBackground() -> RxSwift.Observable<Self.E> {
        return self.subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background)).observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
    }
}
