//
//  NSFont+Italic.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Cocoa

internal extension NSFont {
    /// Returns the standard system font with the italic symbolic traits at the specified size.
    static func italicSystemFont(ofSize size: CGFloat) -> NSFont {
        let regularFont = NSFont.systemFont(ofSize: size)
        let italicDescriptior = regularFont.fontDescriptor.withSymbolicTraits(.italic)
        return NSFont(descriptor: italicDescriptior, size: size)!
    }

    /// Returns the standard system font with the bold and italic symbolic traits at the specified size.
    static func boldItalicSystemFont(ofSize size: CGFloat) -> NSFont {
        let regularFont = NSFont.boldSystemFont(ofSize: size)
        let italicDescriptior = regularFont.fontDescriptor.withSymbolicTraits([.bold, .italic])
        return NSFont(descriptor: italicDescriptior, size: size)!
    }
}
