//
//  Created by Daniel Langh on 24/03/16.
//  Copyright © 2016 rumori. All rights reserved.
//

import UIKit

public extension UIView {
    
    /**
     This method returns the nib name associated with the current class.

     Default implementation returns the class name.
     You can override this method in your class to specify a different name.
     
     - Returns: the nib name associated with the current class
     */
    class func nibName() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
    // MARK:

    /**
    This method tries to initialize the view from an associated nib file.
    
    The name of the nib is determined by calling `nibName()`. Once the nib is found the objects in the nib get instantiated.
    Returns the first object from the nib if the object's class is matching with the current class, else it returns nil.
    
    - Returns: the initiated view object matching the current class or nil
    */
    class func instantiateFromNib() -> Self? {
        return self.instantiateFromNib(nil)
    }

    /**
     This method tries to initialize the view from an associated nib file.
     
     The name of the nib is determined by calling `nibName()`. Once the nib is found the objects in the nib get instantiated.
     Returns the first object from the nib if the object's class is matching with the current class, else it returns nil.
     
     - Parameter owner: The object to use as the owner of the nib file. If the nib file has an owner, you must specify a valid object for this parameter.
     
     - Returns: the initiated view object matching the current class or nil
     */
    class func instantiateFromNib(owner:AnyObject?) -> Self? {
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
    class func instantiateFromNib(owner:AnyObject?, options:[NSObject : AnyObject]?) -> Self? {

        /**
        We need this little hack, so the compiler will infer the type from Self.
        This will hide all tricks from the outside.
        http://stackoverflow.com/questions/33200035/return-instancetype-in-swift
        */
        return instantiateFromNibHelper(owner, options:options)
    }

    private class func instantiateFromNibHelper<T>(owner:AnyObject?, options:[NSObject : AnyObject]?) -> T? {
        
        if let nib = self.getNib() {
            let views = nib.instantiateWithOwner(owner, options: options)
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
    class func getNib() -> UINib? {

        let bundle = NSBundle(forClass: self)
        
        let nibName = self.nibName()
        if let _ = bundle.pathForResource(nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: bundle)
        } else {
            print("Could not find Nib for class \"\(self)\"")
        }
        return nil
    }
}