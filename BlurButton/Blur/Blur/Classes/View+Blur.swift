/*
 MIT License
 
 Copyright (c) 2017 Hai Kieu
 
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


import Foundation
import UIKit

public extension UIView {
    
    public func blink() {
        let fromAlpha : CGFloat = self.alpha
        let toAlpha : CGFloat = fromAlpha == 1 ? 0.9 : 1
        blink(from: fromAlpha, to: toAlpha)
    }
    
    public func blink(from fromAlpha: CGFloat, to toAlpha: CGFloat) {
        
        self.isHidden = false
        self.alpha = fromAlpha
        
        UIView.beginAnimations("splash_animation", context: nil)
        //Config animation
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationDuration(1)
        UIView.setAnimationRepeatCount(.greatestFiniteMagnitude)
        UIView.setAnimationRepeatAutoreverses(true)
        //Animate something
        self.alpha = toAlpha
        //Perform animation
        UIView.commitAnimations()
    }
    

}
