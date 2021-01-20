//
//  StrikethroughStyleParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Foundation

/// Finds and parses instances of strikethrough text
public struct StrikethroughStyleParser: MarkdownParser, RegexBasedParser {
    /// Initialize a strikethrough text parser
    /// - Parameter strikethroughStyle: The style that should be used
    /// for strikethrough text.
    public init(strikethroughStyle: MKUnderlineStyle = .single) {
        self.attributes = [.strikethroughStyle: strikethroughStyle.rawValue]
    }

    /// The regular expression pattern for strikethrough tags.
    /// Captured group 1 is the text that should be striked-through.
    internal static let pattern: StaticString = "~~(.*?)~~"

    /// No regex matching options should be used for strikethrough matching
    internal static let regexOptions: NSRegularExpression.Options = .init()

    /// The strikethrough attribute configuration
    internal let attributes: [NSAttributedString.Key: Any]

    /// Finds regex matches of the strikethrough pattern,
    /// applying the desired attribute when found,
    /// and removing the `~~` delimiter.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? {
        match(in: attributedString)
    }
}
