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

fileprivate let kBlurViewTag = 3232

/// This is lightweight protocol to help add a blur effect to any kind of UIView, especially UIButton,...
public protocol Blur {
    
    ///Config blur effect style by developer
    func configBlurEffect() -> UIBlurEffectStyle
    
    ///Config blur view alpha by developer
    func configBlurAlpha() -> CGFloat
    
    /// Make blur
    ///
    /// - Parameter animated: to animate it
    
    func blur(animated: Bool)
    /// deblur
    ///
    /// - Parameter animated: to animate it
    func deBlur(animated: Bool)
    
    //MARK: - Callbacks method
    /// Callback before bluring
    func willBlur()
    /// Callback after bluring
    func didBlur()
    /// Callback before de-bluring
    func willDeblur()
    /// Callback after de-bluring
    func didDeblur()
}

public extension Blur where Self : UIView {
    
    //MARK: - config some params
    func configBlurEffect() -> UIBlurEffectStyle { return .regular }
    func configBlurAlpha() -> CGFloat { return 1.0 }
    
    public func blur(animated: Bool) {
        
        let blurView = findBlurView() ?? {
            //Setup a new blur view
            let blurView = createBlurBgView()
            blurView.frame = self.bounds
            //This must be false to pass user interaction to beneath view
            blurView.isUserInteractionEnabled = false
            self.addSubview(blurView)
            return blurView
            }()
        
        //Alway send it to back
        self.sendSubview(toBack: blurView)
        
        //Prepare for animation
        blurView.isHidden = false
        blurView.alpha = 0
        
        //Animate
        willBlur()
        UIView.animate(withDuration: animated ? 1 : 0, animations: {
            blurView.alpha = 1
        }) { [weak self] (Bool) in
            self?.didBlur()
            blurView.blink()
        }
    }
    
    public func deBlur(animated: Bool) {
        //If there's no blurview, no need to do anything
        guard let blurView = findBlurView() else { return }
        
        willDeblur()
        UIView.animate(withDuration: animated ? 1 : 0, animations: {
            blurView.alpha = 0
        }) { [weak self] (Bool) in
            blurView.isHidden = true
            self?.didDeblur()
        }
    }
    
    //MARK: - Default callback handlers
    func willBlur() {}
    func didBlur() {}
    func willDeblur() {}
    func didDeblur() {}
    
    //MARK: - Private functions
    private func createBlurBgView() -> UIVisualEffectView {
        let blurView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: configBlurEffect()))
        blurView.alpha = configBlurAlpha()
        blurView.tag = kBlurViewTag
        return blurView
    }
    
    private func findBlurView() -> UIVisualEffectView? {
        for view in self.subviews {
            if view.tag == kBlurViewTag {
                return view as? UIVisualEffectView
            }
        }
        return nil
    }
}

/// Sub-protocol of blur which provides a extra light style of blur
public protocol BlurExtraLight : Blur { }
/// Sub-protocol of blur which provides a light style of blur
public protocol BlurLight : Blur { }
/// Sub-protocol of blur which provides a dark style of blur
public protocol BlurDark : Blur { }
/// Sub-protocol of blur which provides a prominent style of blur
public protocol BlurProminent : Blur { }

public extension BlurExtraLight where Self : UIView { func configBlurEffect() -> UIBlurEffectStyle { return .extraLight }}
public extension BlurLight where Self : UIView { func configBlurEffect() -> UIBlurEffectStyle { return .light }}
public extension BlurDark where Self : UIView { func configBlurEffect() -> UIBlurEffectStyle { return .dark }}
public extension BlurProminent where Self : UIView { func configBlurEffect() -> UIBlurEffectStyle { return .prominent }}


