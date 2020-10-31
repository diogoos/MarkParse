//
//  BoldStyleParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Cocoa

/// Finds instances of bold text, removing the delimiter,
/// and adding the correct font.
public struct BoldStyleParser: MarkdownParser, RegexBasedParser {
    /// The font that should be used for bold text
    public let font: NSFont

    /// Initialize a bold text parser
    /// - Parameter font: The font that should be used for bold text.
    /// Defaults to the bold system font, of size 14.
    public init(font: NSFont = .boldSystemFont(ofSize: 14)) {
        self.font = font
        self.attributes = [.font: font]
    }

    /// The regular expression pattern for bold tags.
    /// Captured group 1 is the text that should be bolded.
    internal static let pattern: StaticString = "\\*\\*(.*?)\\*\\*"

    /// Bold text can be used across lines, so dots should match line separators
    internal static let regexOptions: NSRegularExpression.Options = .dotMatchesLineSeparators

    /// When bold text is identified, apply the desired font.
    internal let attributes: [NSAttributedString.Key: Any]

    /// Finds regex matches of the bold pattern,
    /// applying the bold attribute when found,
    /// and removing the delimiters.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? {
        match(in: attributedString)
    }
}
