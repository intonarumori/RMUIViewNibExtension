//
//  UIViewNibExtensionTests.swift
//  UIViewNibExtensionsExample
//
//  Created by Daniel Langh on 09/04/16.
//  Copyright © 2016 rumori. All rights reserved.
//

import XCTest
@testable import UIViewNibExtensionsExample

class UIViewNibExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_whenViewIsInstantiatedFromNib_withCustomNibName_thenViewIsCreated() {
        
        // given
        XCTAssertEqual(DifferentNameView.nibName(), "DifferentXibNameView")
        
        // when
        let view = DifferentNameView.instantiateFromNib()
        
        // then
        XCTAssertNotNil(view)
    }
    
    func test_whenViewIsInstantiatedFromNib_withDefaultCalculatedNibName_thenViewIsCreated() {

        // given
        XCTAssertEqual(SameNameView.nibName(), "SameNameView")
        
        // when
        let view = SameNameView.instantiateFromNib()
        
        // then
        XCTAssertNotNil(view)
    }
    
    func test_whenViewIsInstantiatedFromNib_withMissingNibFile_thenViewIsNil() {
        
        // given
        XCTAssertEqual(MissingXibView.nibName(), "MissingXibView")
        
        // when
        let view = MissingXibView.instantiateFromNib()
        
        // then
        XCTAssertNil(view)
    }
    
    func test_whenViewIsInstantiatedFromNib_andNibFileIsPresent_andFirstObjectInNibIsNotMatchingType_thenViewIsNil() {

        // given
        XCTAssertEqual(MismatchingTypeXibView.nibName(), "MismatchingTypeXibView")
        
        // when
        let view = MismatchingTypeXibView.instantiateFromNib()
        
        // then
        XCTAssertNil(view)
    }
}
