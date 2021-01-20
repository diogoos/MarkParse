//
//  FontModifier.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Foundation

/// This modifier applies a given font wherever no font has been defined.
/// It acts as a replacement for the default NSAttributedString font (which is Helvetica pt. 12),
/// while maintaing other applied font attributes intact.
public struct FontModifier: MarkdownParser {
    /// MKFont that should be used when no other font attributes are defined.
    public let defaultFont: MKFont

    /// Initialize a new FontModifier
    /// - Parameter defaultFont: The MKFont that should be used when no other font attributes are defined.
    public init(defaultFont: MKFont) {
        self.defaultFont = defaultFont
    }

    /// Enumerate the font attributes in the attributed string, and determine the ranges where no fonts are applied.
    /// In these ranges, edit the attributed string, and apply the default font, specified by the initalizer.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? {
        attributedString.enumerateAttribute(.font,
                                            in: NSRange(location: 0, length: attributedString.length)
                                            ) { (value, range, _) in
            if value == nil {
                attributedString.beginEditing()
                attributedString.addAttribute(.font,
                                              value: defaultFont,
                                              range: range)

                attributedString.endEditing()
            }
        }
        return attributedString
    }
}
