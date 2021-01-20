//
//  BodyTextParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Foundation

/// Parses any given text into a body paragraph.
/// - Warning: This should **always** be the last item in the array of parsers, because
/// it will gladly parse any given input. This may preventing other parsers from defining lines,
/// which would therefore result in incomplete formatting.
public struct BodyParser: MarkdownParser {
    /// Initalize a NSAttributedString containing the given string, with no additional attributes.
    public func define(line: String) -> NSAttributedString? {
        NSAttributedString(string: line)
    }
}
