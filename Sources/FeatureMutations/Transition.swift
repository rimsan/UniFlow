/*
 
 MIT License
 
 Copyright (c) 2016 Maxim Khatskevich (maxim@khatskevi.ch)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

import XCERequirement

//===

public
extension Feature
{
    static
    var transition: Transition<Self>.Type
    {
        return Transition<Self>.self
    }
}

//===

public
struct Transition<F: Feature>: GlobalMutationExt
{
    public
    struct From<S: FeatureState> where S.ParentFeature == F
    {
        public
        let oldState: S
    }
    
    public
    struct Between<From: FeatureState, Into: FeatureState> where
        From.ParentFeature == F,
        Into.ParentFeature == F
    {
        public
        let oldState: From
        
        public
        let newState: Into
    }
    
    //===
    
    static
    var kind: FeatureMutationKind { return .update }
    
    let apply: (GlobalModel) -> GlobalModel
    
    //===
    
    public
    let oldState: FeatureRepresentation
    
    public
    let newState: FeatureRepresentation
    
    //===
    
    init<Into>(from oldState: FeatureRepresentation, into newState: Into) where
        Into: FeatureState,
        Into.ParentFeature == F
    {
        self.oldState = oldState
        self.newState = newState
        self.apply = { $0.store(newState) }
    }
}

public
typealias TransitionFrom<S: FeatureState> = Transition<S.ParentFeature>.From<S>

#if swift(>=3.2)
    
public
typealias TransitionBetween<From: FeatureState, Into: FeatureState> =
    Transition<From.ParentFeature>.Between<From, Into>
    where From.ParentFeature == Into.ParentFeature
    
#endif

//===

public
extension Transition.From
{
    static
    func into<Into: FeatureState>(
        scope: String = #file,
        context: String = #function,
        _ newState: Into
        ) -> Action
        where Into.ParentFeature == F
    {
        return Action(scope, context, self) { model, _ in
            
            let oldState =
            
            try Require("\(F.name) is in \(S.self) state").isNotNil(
                
                model >> S.self
            )
            
            //---
            
            return Transition(from: oldState, into: newState)
        }
    }
}

//===

public
extension Transition.Between where Into: SimpleState
{
    static
    func automatic(
        scope: String = #file,
        context: String = #function,
        completion: ((@escaping SubmitAction) -> Void)? = nil
        ) -> Action
    {
        return Action(scope, context, self) { model, submit in
            
            let oldState =
                
            try Require("\(F.name) is in \(From.self) state").isNotNil(
                
                model >> From.self
            )
            
            //---
            
            let newState = Into.init()
            
            //---
            
            completion?(submit)
            
            //---
            
            return Transition(from: oldState, into: newState)
        }
    }
}

//===

public
extension Transition.Between
{
    static
    func via(
        scope: String = #file,
        context: String = #function,
        body: @escaping (From, Become<Into>, @escaping SubmitAction) throws -> Void
        ) -> Action
    {
        return Action(scope, context, self) { model, submit in
            
            let oldState =
                
            try Require("\(F.name) is in \(From.self) state").isNotNil(
                
                model >> From.self
            )
            
            //---
            
            var newState: Into!
            
            //---
            
            try body(oldState, { newState = $0 }, submit)
            
            //---
            
            try Require("New state for \(F.name) is set").isNotNil(
                
                newState
            )
            
            //---
            
            return Transition(from: oldState, into: newState)
        }
    }
}
