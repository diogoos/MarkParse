//
//  TextColorModifier.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Foundation

/// This modifier applies a given text color wherever no text color has been defined.
/// It acts as a replacement for the default foreground color (black),
/// while maintaing other applied color attributes intact.
public struct TextColorModifier: MarkdownParser {
    /// MKColor that should be used when no other color attributes are defined.
    public let defaultColor: MKColor

    /// Initialize a new text color modifier
    /// - Parameter defaultColor: The MKColor that should be used when no other color attributes are defined.
    /// this defaults to the text color.
    public init(defaultColor: MKColor = .textColor) {
        self.defaultColor = defaultColor
    }

    /// Enumerate the color attributes in the attributed string, and determine the ranges where no colors are applied.
    /// In these ranges, edit the attributed string, and apply the color, specified by the initalizer.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? {
        attributedString.enumerateAttribute(.foregroundColor,
                                            in: NSRange(location: 0, length: attributedString.length)
        ) { (value, range, _) in
            if value == nil {
                attributedString.beginEditing()
                attributedString.addAttribute(.foregroundColor,
                                              value: defaultColor,
                                              range: range)

                attributedString.endEditing()
            }
        }
        return attributedString
    }
}
