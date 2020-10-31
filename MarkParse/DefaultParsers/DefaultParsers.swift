//
//  DefaultParsers.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Cocoa

extension MarkdownRenderer {
    /// An array containing the default parsers that are included with the framework
    public static let defaultParsers: [MarkdownParser] = [
        HeadingParser(),
        ThematicBreakParser(),
        LinkParser(),
        CodeBlockParser(),
        BulletedListParser(),
        BoldItalicStyleParser(),
        BoldStyleParser(),
        ItalicStyleParser(),
        StrikethroughStyleParser(),
        InlineCodeStyleParser(),
        BodyParser(),
        TextColorModifier(),
        FontModifier(defaultFont: NSFont.systemFont(ofSize: 14))
    ]
}
