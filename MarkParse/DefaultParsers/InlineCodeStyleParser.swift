//
//  InlineCodeStyleParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Cocoa

/// Finds instances of inline code, and applies
/// the speciifed styling.
public struct InlineCodeStyleParser: MarkdownParser, RegexBasedParser {
    /// The font that should be used for inline code
    public let font: NSFont

    /// The color that should be used in the background of inline code.
    public let backgroundColor: NSColor

    /// Initialize a bold text parser
    /// - Parameter font: The font that should be used for bold text.
    /// Defaults to the monospaced system font, of size 14.
    /// - Parameter backgroundColor: The background color
    /// that should be used for inline code. Defaults to the window
    /// color.
    public init(font: NSFont = .monospacedSystemFont(ofSize: 14, weight: .regular),
                backgroundColor: NSColor = .windowBackgroundColor) {
        self.font = font
        self.backgroundColor = backgroundColor
        self.attributes = [.font: font, .backgroundColor: backgroundColor]
    }

    /// The regular expression pattern for inline code.
    internal static let pattern: StaticString = "`(.*?)`"

    /// No regular expression options should be used.
    internal static let regexOptions: NSRegularExpression.Options = .init()

    internal let attributes: [NSAttributedString.Key: Any]

    /// Finds regex matches of the inline code pattern,
    /// applying correct attributes and removing the delimiter.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? {
        match(in: attributedString)
    }
}
