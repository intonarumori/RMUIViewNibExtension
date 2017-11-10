// UIView+NibExtensions.swift
//
// Copyright (c) 2016 Daniel Langh
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

public extension UIView {
    
    /**
     This method returns the nib name associated with the current class.

     Default implementation returns the class name.
     You can override this method in your class to specify a different name.
     
     - Returns: the nib name associated with the current class
     */
    @objc public class func nibName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    // MARK:

    /**
    This method tries to initialize the view from an associated nib file.
    
    The name of the nib is determined by calling `nibName()`. Once the nib is found the objects in the nib get instantiated.
    Returns the first object from the nib if the object's class is matching with the current class, else it returns nil.
    
    - Returns: the initiated view object matching the current class or nil
    */
    @objc public class func instantiateFromNib() -> Self? {
        return self.instantiateFromNib(nil)
    }

    /**
     This method tries to initialize the view from an associated nib file.
     
     The name of the nib is determined by calling `nibName()`. Once the nib is found the objects in the nib get instantiated.
     Returns the first object from the nib if the object's class is matching with the current class, else it returns nil.
     
     - Parameter owner: The object to use as the owner of the nib file. If the nib file has an owner, you must specify a valid object for this parameter.
     
     - Returns: the initiated view object matching the current class or nil
     */
    @objc public class func instantiateFromNib(_ owner:AnyObject?) -> Self? {
        return self.instantiateFromNib(owner, options: nil)
    }
    
    /**
     This method tries to initialize the view from an associated nib file.
     
     The name of the nib is determined by calling `nibName()`. Once the nib is found the objects in the nib get instantiated.
     Returns the first object from the nib if the object's class is matching with the current class, else it returns nil.
     
     - Parameter owner: The object to use as the owner of the nib file. If the nib file has an owner, you must specify a valid object for this parameter.
     - Parameter options: A dictionary containing the options to use when opening the nib file
     
     - Returns: the initiated view object matching the current class or nil
    */
    @objc public class func instantiateFromNib(_ owner:AnyObject?, options:[AnyHashable: Any]?) -> Self? {

        /**
        We need this little hack, so the compiler will infer the type from Self.
        This will hide all tricks from the outside.
        http://stackoverflow.com/questions/33200035/return-instancetype-in-swift
        */
        return instantiateFromNibHelper(owner, options:options)
    }

    fileprivate class func instantiateFromNibHelper<T>(_ owner:AnyObject?, options:[AnyHashable: Any]?) -> T? {
        
        if let nib = self.getNib() {
            let views = nib.instantiate(withOwner: owner, options: options)
            if let view = views.first as? T {
                return view
            } else {
                print("Class of first view in Nib does not match current class \"\(self)\"")
            }
        }
        return nil
    }

    /**
     The `nib` object associated with the current class.
     
     Gets the actual `UINib` object for the current class if the nib in the bundle is found based on the `nibName()` method.
     
     - Returns: the `UINib` object or `nil`
     */
    @objc public class func getNib() -> UINib? {

        let bundle = Bundle(for: self)
        
        let nibName = self.nibName()
        if let _ = bundle.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: bundle)
        } else {
            print("Could not find Nib for class \"\(self)\"")
        }
        return nil
    }
}
