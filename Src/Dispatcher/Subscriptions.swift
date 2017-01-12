//
//  Subscriptions.swift
//  MKHUniFlow
//
//  Created by Maxim Khatskevich on 1/12/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//=== MARK: Public

public
extension Dispatcher
{
    func subscribe(
        _ observer: AnyObject,
        updateNow: Bool = true
        ) -> SubscriptionBlank<State>
    {
        return
            SubscriptionBlank(
                observer: observer,
                dispatcher: self,
                initialUpdate: updateNow)
    }
    
    func unsubscribe(_ observer: AnyObject)
    {
        subscriptions
            .removeObject(forKey: observer)
    }
}

//=== MARK: Internal

extension Dispatcher
{
    func register(_ observer: AnyObject,
                  _ subscription: Subscription<State>,
                  _ initialUpdate: Bool = true)
    {
        subscriptions
            .setObject(subscription, forKey: observer)
        
        //===
        
        if initialUpdate
        {
            notify(subscription)
        }
    }
    
    func notifySubscriptions()
    {
        _ = subscriptions
            .objectEnumerator()?
            .allObjects
            .flatMap({ $0 as? Subscription<State> })
            .map(notify)
    }
    
    func notify(_ subscription: Subscription<State>)
    {
        subscription.onConvert(state)
            .map(subscription.onUpdate)
    }
}
