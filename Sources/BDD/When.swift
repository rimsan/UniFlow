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
struct When
{
    public
    typealias Handler = (GlobalMutation) -> Bool // continue if -> YES
    
    public
    typealias SpecialHandler = (GlobalMutation) -> GlobalMutation?
    
    //===
    
    let specification: String
    let implementation: Handler
    
    // MARK: - Initializers
    
    init(
        _ specification: String,
        _ standardHanlder: @escaping Handler
        )
    {
        self.specification = specification
        self.implementation = standardHanlder
    }
    
    init(
        _ specification: String,
        _ specialHanlder: @escaping SpecialHandler
        )
    {
        self.specification = specification
        self.implementation = { return specialHanlder($0) != nil }
    }
}

// MARK: - Connector

public
extension When
{
    public
    struct Connector<GivenResult>
    {
        let given: [Given]
        let when: When
        
        // MARK: - Initializers
        
        init(with given: [Given], when: When)
        {
            self.given = given
            self.when = when
        }
    }
}
