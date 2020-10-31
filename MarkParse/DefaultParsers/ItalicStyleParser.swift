//
//  ItalicStyleParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Cocoa

/// Finds instances of italic text, removing the delimiter,
/// and adding the correct font.
public struct ItalicStyleParser: MarkdownParser, RegexBasedParser {
    /// The font that should be used for italic text
    public let font: NSFont

    /// Initialize a italic text parser
    /// - Parameter font: The font that should be used for bold text.
    /// Defaults to the italic system font, of size 14.
    public init(font: NSFont? = nil) {
        self.font = font ?? .italicSystemFont(ofSize: 14)
        self.attributes = [.font: self.font]
    }

    /// The regular expression pattern for italic tags.
    /// Captured group 1 is the text that should be italicized.
    internal static let pattern: StaticString = "\\*(.*?)\\*"

    /// Italic text can be used across lines, so dots should match line separators
    internal static let regexOptions: NSRegularExpression.Options = .dotMatchesLineSeparators

    /// When italic text is identified, apply the desired font.
    internal let attributes: [NSAttributedString.Key: Any]

    /// Finds regex matches of the italic pattern,
    /// applying the italic font attribute when found,
    /// and removing the `*` delimiter.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? {
        match(in: attributedString)
    }
}
