//
//  HeadingParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Cocoa

/// Parses Markdown headings, identified by #s in the beginning of lines.
/// Takes into consideration the levels for each heading, from h1 through h6.
/// Any level outside of this range (such as the nonexistent h7)
/// will be ignored and rendered as body text.
/// Headings level 1 and 2 will also include a thematic break below them.
public struct HeadingParser: MarkdownParser {
    /// A conversion table for heading font sizes, that determines how much
    /// a given font should scale, compared to the base font size.
    /// For example, an H1 header has twice the size of the base font size.
    public typealias HeadingSizeTable = [Int: CGFloat]

    /// The default relative sizes of fonts for headers.
    /// - SeeAlso: `HeadingSizeTable`
    static let defaultSizeTable: HeadingSizeTable = [
        1: 2,
        2: 1.5,
        3: 1.25,
        4: 1,
        5: 0.875,
        6: 0.85
    ]

    /// The font family that headings should conform to. By default, this is the bold system font.
    public let fontFamily: NSFont

    /// The base font size for a heading - the size of all headings are calculated based on this
    public let baseFontSize: CGFloat

    /// The conversion table for font sizes in headers.
    /// For instance, an H1 element is twice the size of the base font.
    /// - SeeAlso: `HeadingSizeTable`
    public let fontSizeConversionTable: HeadingSizeTable

    /// Get the font for a specific heading level, using the conversion table
    /// and the specified fontFamily
    /// - Precondition: The heading level must not be lower than 1 or higher than 6
    /// - Parameter forHeadingLevel: The heading level as an integer - 1 is higher, 6 is lower
    /// - Returns: An NSFont element that uses the specified font family, base font size, and conversion table
    private func headingFont(forLevel level: Int) -> NSFont {
        precondition(level > 0 && level <= 6, "Invalid heading level \(level): heading level must be between 1 and 6")

        let fontSize = baseFontSize * fontSizeConversionTable[level]!
        let fontDescriptor = fontFamily.fontDescriptor.withSize(fontSize)
        return NSFont(descriptor: fontDescriptor, size: fontSize) ?? .systemFont(ofSize: fontSize)
    }

    /// Initalize a new Heading Parser
    /// - Parameter fontFamily: The font famliy that should be used for headings. Defaults to boldSystemFont
    /// - Parameter baseFontSize: The base font size for a heading -
    /// the size of all headings are calculated based on this
    /// - Parameter fontSizeConversionTable: The conversion table for font sizes in headers.
    /// See also `HeadingSizeTable`
    public init(fontFamily: NSFont = .boldSystemFont(ofSize: 16),
                baseFontSize: CGFloat = 16,
                fontSizeConversionTable: HeadingSizeTable? = nil) {
        self.fontFamily = fontFamily
        self.baseFontSize = baseFontSize
        self.fontSizeConversionTable = fontSizeConversionTable ?? Self.defaultSizeTable
    }

    /// Count the number of sequential #s in the beginning of the string.
    /// If this value ranges from 1 to 6, apply the correct heading styling.
    public func define(line: String) -> NSAttributedString? {
        if line.count < 2 { return nil } // at *minimum* we need a # and a space (2 characters)
        if !line.starts(with: "#") { return nil } // if we don't have any #, continue

        var lastChar: Character = "#"
        var headingLevel = 0

        // count how many # we have in the beginning of the line
        repeat {
            lastChar = line[line.index(line.startIndex, offsetBy: headingLevel)]
            headingLevel += 1
        } while lastChar == "#"
        headingLevel -= 1

        if headingLevel > 6 { return nil } // nothing beyond h6 exists

        // if the are no spaces after #, don't make it a header
        let indexAfterPound = line.index(line.startIndex, offsetBy: headingLevel)
        if line[indexAfterPound] != " " { return nil }

        // remove leading #s from string
        let startIndex = line.index(line.startIndex, offsetBy: headingLevel+1)
        let value = String(line[startIndex..<line.endIndex])

        // convert into rich text
        let result = NSMutableAttributedString(string: value, attributes: [
            .font: headingFont(forLevel: headingLevel)
        ])

        // add a thematic break attachment
        if headingLevel < 3 { result.append(ThematicBreakParser.ThematicBreakAttachment()) }

        return result as NSAttributedString
    }
}
