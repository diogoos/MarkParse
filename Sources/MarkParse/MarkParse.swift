//
//  MarkdownParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Foundation

/// The protocol for building a new MarkParse parser.
public protocol MarkdownParser {
    /// Define how a line should be parsed.
    /// This should be implemented for headings, thematic breaks, or other features
    /// that do not depend on other definers to be handled.
    /// - Parameter line: The line it should convert into an attributed string
    /// - Returns: An NSAttributedString based on the recieved string
    func define(line: String) -> NSAttributedString?

    /// Define how a line should be modified.
    /// This should be implemented for links or other features
    /// that modify an existing parsed line.
    /// - Parameter line: The parsed line that should be modified
    /// - Returns: An NSMutableAttributedString that includes the new modifications
    func modify(line: NSMutableAttributedString) -> NSMutableAttributedString?

    /// Define how the whole input should be parsed.
    /// This should be implemented for codeblocks and other features
    /// that can be found across lines, and whose modification
    /// does not significantly change the whole
    /// - Parameter attributedString: The entire, semi-parsed, markdown string
    /// - Returns: An NSMutableAttributedString that includes the parser's modifications, while preserving past ones
    func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString?
}

extension MarkdownParser {
    /// By default, this parser does not define any lines.
    public func define(line: String) -> NSAttributedString? { nil }

    /// By default, this parser does not apply modifcations to individual lines.
    public func modify(line: NSMutableAttributedString) -> NSMutableAttributedString? { nil }

    /// By default, this parser does not apply any modifications the whole text.
    public func modify(attributedString: NSMutableAttributedString) -> NSMutableAttributedString? { nil }
}
