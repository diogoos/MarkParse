//
//  MKFontStyles.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Foundation
import CoreGraphics

extension MKFont {
    /// Returns the standard system font with the italic symbolic traits at the specified size.
    internal static func italicSystemFont(ofSize size: CGFloat) -> MKFont {
        let regularFont = MKFont.systemFont(ofSize: size)

        let italicDescriptior = regularFont.fontDescriptor.withSymbolicTraits(.italic)

        #if canImport(UIKit)
            return MKFont(descriptor: italicDescriptior!, size: size)
        #elseif canImport(AppKit)
            return MKFont(descriptor: italicDescriptior, size: size)!
        #endif
    }

    /// Returns the standard system font with the bold and italic symbolic traits at the specified size.
    internal static func boldItalicSystemFont(ofSize size: CGFloat) -> MKFont {
        let regularFont = MKFont.boldSystemFont(ofSize: size)
        let boldItalicDescriptior = regularFont.fontDescriptor.withSymbolicTraits([.bold, .italic])

        #if canImport(UIKit)
        return MKFont(descriptor: boldItalicDescriptior!, size: size)
        #elseif canImport(AppKit)
        return MKFont(descriptor: boldItalicDescriptior, size: size)!
        #endif
    }

    /// Returns a monospace font adequate for the system
    public static func monospaceSystemFont(ofSize size: CGFloat) -> MKFont {
        #if canImport(UIKit)
        if #available(iOS 13.0, tvOS 13.0, *) {
            return MKFont.monospacedSystemFont(ofSize: size, weight: .regular)
        }

        return MKFont(name: "Menlo-Regular", size: size)! // avaliable in ios 7 and up (min deployment is ios 9)
        #elseif canImport(AppKit)
        if #available(macOS 10.15, *) {
            return MKFont.monospacedSystemFont(ofSize: size, weight: .regular)
        }

        return MKFont(name: "Menlo-Regular", size: size)!
        #endif
    }
}
