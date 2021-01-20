//
//  BulletedListParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/26/20.
//

import Foundation

/// Parses bulleted lists starting with `* ` and `- `
public struct BulletedListParser: MarkdownParser {

    /// Removes bullets from string, when bullets are present.
    /// - Returns: The text without the bullet if the bullet exists, otherwise, returns nil.
    /// - Parameter bullet: A string representing the type of bullet to be dound
    /// - Parameter line: The line that containing the bullet and the text.
    internal func bulletlessText(bullet: String, line: String) -> String? {
        let isBulleted = line.starts(with: bullet + " ")
        if isBulleted {
            var inter = line.components(separatedBy: bullet + " ")
            inter.removeFirst()
            return inter.joined(separator: bullet + " ")
        }
        return nil
    }

    /// The paragraph style for bullets
    internal static let paragraphStyle: MKParagraphStyle = {
        var style: MKMutableParagraphStyle
        style = MKParagraphStyle.default.mutableCopy() as! MKMutableParagraphStyle // swiftlint:disable:this force_cast
        style.tabStops = [MKTextTab(textAlignment: .left, location: 15, options: .init())]
        style.defaultTabInterval = 15
        style.firstLineHeadIndent = 0
        style.paragraphSpacing = 10
        style.headIndent = 15

        return style
    }()

    /// Determines if the line starts with a bullet-like point, and converts it into
    /// an actual bullet.
    public func define(line: String) -> NSAttributedString? {
        if line.count < 2 { return nil }

        if let item = bulletlessText(bullet: "*", line: line) ??
                      bulletlessText(bullet: "-", line: line) {
            return NSAttributedString(string: "\u{2022}\t" + item, attributes: [
                .paragraphStyle: Self.paragraphStyle
            ])
        }

        return nil
    }
}
