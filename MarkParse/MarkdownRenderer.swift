//
//  MarkdownRenderer.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Foundation

/// The parser class for Markdown. It handles how parsers should be called, and how the conversion to
/// different formats should take place.
public class MarkdownRenderer {
    /// The MarkdownParsers associated to the instance of this parser.
    public let parsers: [MarkdownParser]

    /// Initalizes a MarkdownRenderer
    /// - Parameter parsers: An array of markdown parsers, ordered by priority,
    /// that should be used to parse text into markdown.
    public init(parsers: [MarkdownParser]) {
        self.parsers = parsers
    }

    /// Returns an `NSAttributedString` with rendered markdown from a given string
    /// - Parameter base: the string, containing markdown, that should be parsed and rendered
    public func attributedString(from base: String) -> NSAttributedString {
        var attributedString = NSMutableAttributedString()

        // line by line modification
        for line in base.components(separatedBy: "\n") {
            var attributedLine: NSMutableAttributedString?

            // line definers
            for parser in parsers {
                if let parsedLine = parser.define(line: line) {
                    attributedLine = NSMutableAttributedString(attributedString: parsedLine)
                    break
                }
            }

            if attributedLine == nil {
                attributedLine = NSMutableAttributedString(string: line)
            }

            // line modifiers
            for parser in parsers {
                if let modifedLine = parser.modify(line: attributedLine!) {
                    attributedLine = modifedLine
                }
            }

            attributedString.append(NSAttributedString(string: "\n"))
            attributedString.append(attributedLine!)
        }

        // block modification
        for parser in parsers {
            if let modifedBlock = parser.modify(attributedString: attributedString) {
                attributedString = modifedBlock
            }
        }

        return attributedString as NSAttributedString
    }
}
