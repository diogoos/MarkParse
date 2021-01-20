//
//  BoldItalicStyleParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Foundation

/// Finds instances of bold italic text, removing the delimiter,
/// and adding the correct font.
public struct BoldItalicStyleParser: MarkdownParser, RegexBasedParser {
    /// The font that should be used for bold italic text
    public let font: MKFont

    /// Initialize a italic text parser
    /// - Parameter font: The font that should be used for bold italic text.
    /// Defaults to the bold italic system font, of size 14.
    public init(font: MKFont? = nil) {
        self.font = font ?? .boldItalicSystemFont(ofSize: 14)
        self.attributes = [.font: self.font]
    }

    /// The regular expression pattern for bold italic tags.
    /// Captured group 1 is the text that should be bolded and italicized.
    internal static let pattern: StaticString = "\\*\\*\\*(.*?)\\*\\*\\*"

    /// Bold-Italic text can be used across lines, so dots should match line separators
    internal static let regexOptions: NSRegularExpression.Options = .dotMatchesLineSeparators

    /// When bold italic text is identified, apply the desired font.
    internal let attributes: [NSAttributedString.Key: Any]

    /// Finds regex matches of the bold italic pattern,
    /// applying the desired font attribute when found,
    /// and removing the `***` delimiter.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? {
        match(in: attributedString)
    }
}
