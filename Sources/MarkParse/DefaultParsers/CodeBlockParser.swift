//
//  CodeBlockParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Foundation

/// Parses code blocks, removing the delimiters, and adding font and background attributes.
/// - Note: This structure could be converted to conform to a regex based parser,
/// however, to add code highlighting in the future, it will currently retain it's custom implementation
public struct CodeBlockParser: MarkdownParser {
    /// The font that should be used inside code blocks.
    public let font: MKFont

    /// The background color that should be used for code blocks
    public let backgroundColor: MKColor

    /// A regular expression that searches for the defined delimiter, capturing the text next to the first line,
    /// and capturing the text in between the two instances of the delimiter.
    /// Group 1 is the language and Group 2 is the code.
    internal static let blockRegex = NSRegularExpression(staticPattern: "```(.*?)\n(.*?)```\n",
                                                         options: .dotMatchesLineSeparators)

    /// Initalizes a code block parser
    /// - Parameter font: The font that should be used inside code blocks.
    /// Defaults to monospaced system font, size 14.
    /// - Parameter backgroundColor: The background color that should be used
    /// in code blocks. Defaults to the window color.
    public init(font: MKFont = .systemFont(ofSize: 14),//.monospacedSystemFont(ofSize: 14, weight: .regular),
                backgroundColor: MKColor = .backgroundColor) {
        self.font = font
        self.backgroundColor = backgroundColor
    }

    /// Find instances of blocks of code, removing the delimiters, adjusting the font,
    /// and adding a certain background.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? {
        let matches = Self.blockRegex.matches(in: attributedString.string,
                                              options: [],
                                              range: NSRange(location: 0, length: attributedString.length))

        let original = attributedString.string.copy() as! NSString // swiftlint:disable:this force_cast

        var locationCharShift: Int = 0
        for match in matches {
            let matchString = original.substring(with: match.range)
            let codeString = original.substring(with: match.range(at: 2))
            let updatedRange = NSRange(location: match.range.location - locationCharShift, length: match.range.length)

            // add attributes
            attributedString.addAttributes([
                .font: font,
                .backgroundColor: backgroundColor
            ], range: updatedRange)
            attributedString.mutableString.replaceCharacters(in: updatedRange, with: codeString)

            // add deviation
            locationCharShift += matchString.count - codeString.count
        }

        return attributedString
    }
}
