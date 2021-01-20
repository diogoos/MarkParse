//
//  MKFont+Italic.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Foundation
import CoreGraphics

internal extension MKFont {
    /// Returns the standard system font with the italic symbolic traits at the specified size.
    static func italicSystemFont(ofSize size: CGFloat) -> MKFont {
        let regularFont = MKFont.systemFont(ofSize: size)

        let italicDescriptior = regularFont.fontDescriptor.withSymbolicTraits(.italic)

        #if canImport(UIKit)
            return MKFont(descriptor: italicDescriptior!, size: size)
        #elseif canImport(AppKit)
            return MKFont(descriptor: italicDescriptior, size: size)!
        #endif
    }

    /// Returns the standard system font with the bold and italic symbolic traits at the specified size.
    static func boldItalicSystemFont(ofSize size: CGFloat) -> MKFont {
        let regularFont = MKFont.boldSystemFont(ofSize: size)
        let boldItalicDescriptior = regularFont.fontDescriptor.withSymbolicTraits([.bold, .italic])

        #if canImport(UIKit)
        return MKFont(descriptor: boldItalicDescriptior!, size: size)
        #elseif canImport(AppKit)
        return MKFont(descriptor: boldItalicDescriptior, size: size)!
        #endif
    }
}
