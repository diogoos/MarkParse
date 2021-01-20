//
//  RegexBasedParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Foundation

/// A base parser structure that is used to find and replace strings, adding attributes,
/// using regular expressions.
internal protocol RegexBasedParser {
    /// The regular expression pattern that should be used.
    /// - Important: Captured group 1 should always be
    /// the value that will replace the matched range.
    /// For instance, when bolding, the text `*hi*`,
    /// will be replaced with `hi`, since "hi" is the captured
    /// group 1.
    static var pattern: StaticString { get }

    /// The options that should be used for regular expression matching.
    static var regexOptions: NSRegularExpression.Options { get }

    /// The attributes that should be applied to the text matches.
    var attributes: [NSAttributedString.Key: Any] { get }
}

internal extension RegexBasedParser {
    /// The computed regular expression from the pattern, using the given options
    static var regex: NSRegularExpression {
        NSRegularExpression(staticPattern: Self.pattern, options: Self.regexOptions)
    }

    /// Find the matches to the regular expression, remove the delimiters, and apply the desired attributes.
    func match(in text: NSMutableAttributedString,
               regex: NSRegularExpression = Self.regex) -> NSMutableAttributedString {
        let matchRanges = regex.matches(in: text.string,
                                            options: [],
                                            range: NSRange(location: 0, length: text.string.utf16.count))

        let original = text.string.copy() as! NSString // swiftlint:disable:this force_cast
        var locationCharShift: Int = 0

        for match in matchRanges {
            // get the range for the match
            let matchString = original.substring(with: match.range)
            let textString = original.substring(with: match.range(at: 1))

            // update the range
            let updatedRange = NSRange(location: match.range.location - locationCharShift, length: match.range.length)
            locationCharShift += matchString.count - textString.count

            // add attributes
            text.addAttributes(attributes, range: updatedRange)
            text.mutableString.replaceCharacters(in: updatedRange, with: textString)
        }

        return text
    }
}
