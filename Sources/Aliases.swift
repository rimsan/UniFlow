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

public
typealias UFLAction = Action

public
typealias UFLSubmitAction = SubmitAction

public
typealias UFLBecome<S: UFLFeatureState> = Become<S>

public
typealias UFLActionContext = ActionContext

public
typealias UFLFeature = Feature

public
typealias UFLFeatureRepresentation = FeatureRepresentation

public
typealias UFLFeatureState = FeatureState

public
typealias UFLAutoInitializable = AutoInitializable

public
typealias UFLFeatureStateAuto = FeatureStateAuto

public
typealias UFLDispatcher = Dispatcher

public
typealias UFLGlobalModel = GlobalModel

public
typealias UFLGlobalMutation = GlobalMutation

public
typealias UFLDispatcherInitializable = DispatcherInitializable

public
typealias UFLDispatcherBindable = DispatcherBindable

public
typealias UFLDefaultReporting = DefaultReporting

public
typealias UFLStateObserver = StateObserver

public
typealias UFLInitialization<F: UFLFeature> = Initialization<F>

public
typealias UFLInitializationInto<S: UFLFeatureState> = InitializationInto<S>

public
typealias UFLActualization<F: UFLFeature> = Actualization<F>

public
typealias UFLActualizationIn<S: UFLFeatureState> = ActualizationIn<S>

public
typealias UFLTransition<F: UFLFeature> = Transition<F>

#if swift(>=3.2)
    
public
typealias UFLTransitionBetween<From: UFLFeatureState, Into: UFLFeatureState> =
    TransitionBetween<From, Into>
    where
    From.ParentFeature == Into.ParentFeature
    
#endif

public
typealias UFLTransitionFrom<S: UFLFeatureState> = TransitionFrom<S>

public
typealias UFLTransitionInto<S: UFLFeatureState> = TransitionInto<S>

public
typealias UFLTrigger<F: UFLFeature> = Trigger<F>

public
typealias UFLDeinitialization<F: UFLFeature> = Deinitialization<F>

public
typealias UFLDeinitializationFrom<S: UFLFeatureState> = DeinitializationFrom<S>