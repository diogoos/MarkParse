//
//  ThematicBreakParser.swift
//  MarkParse
//
//  Created by Diogo Silva on 10/25/20.
//

import Foundation

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Parses thematic breaks in markdown, which are identified
/// by lines only containing a sequence of at least two `-`
public struct ThematicBreakParser: MarkdownParser {
    /// Determine if the line starts with two dashes, and contains no other characters
    /// but dashes. If this is the case, replace the line with a `ThematicBreakAttachment`
    public func define(line: String) -> NSAttributedString? {
        if !line.contains("--") { return nil }

        let line = line.trimmingCharacters(in: .whitespacesAndNewlines)
        if line.trimmingCharacters(in: .whitespaces).filter({ $0 != "-" }).count == 0 {
            #if canImport(AppKit)
            return ThematicBreakAttachment()

            #elseif canImport(UIKit)
            let str = NSMutableAttributedString(string: "\n")
            str.append(ThematicBreakAttachment())
            str.append(NSAttributedString(string: "\n"))
            return str
            #endif
        }

        return nil
    }

    #if canImport(UIKit)
    internal class ThematicBreakAttachmentCell: NSTextAttachment {
        override func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
            let width = (textContainer?.size.width) ?? 100
            let bounds = CGRect(origin: .zero, size: CGSize(width: width, height: 1))
            self.bounds = bounds
            return bounds
        }

        override func image(forBounds imageBounds: CGRect, textContainer: NSTextContainer?, characterIndex charIndex: Int) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0)

            guard let ctx = UIGraphicsGetCurrentContext() else { return nil }

            let lineRect = CGRect(origin: .zero, size: bounds.size)
            ctx.addRect(lineRect)
            ctx.setFillColor(gray: 0.6, alpha: 1)
            ctx.setStrokeColor(gray: 0.6, alpha: 1)
            ctx.fillPath()

            guard let drawnImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }

            UIGraphicsEndImageContext()

            return drawnImage
        }
    }
    #elseif canImport(AppKit)
    /// Draws a thematic break
    internal class ThematicBreakAttachmentCell: NSTextAttachmentCell {
        /// Calculates the cell frame, which should begin at the farthest point,
        /// going to the end of the line, with a height of 15
        internal override func cellFrame(for textContainer: NSTextContainer,
                                         proposedLineFragment lineFrag: NSRect,
                                         glyphPosition position: NSPoint,
                                         characterIndex charIndex: Int) -> NSRect {
            NSRect(x: 0, y: 0, width: lineFrag.size.width, height: 15)
        }

        /// Draws the thematic break using the text color at half opacity, at the vertical center,
        /// with a thickness of 1.5
        internal override func draw(withFrame cellFrame: NSRect, in controlView: NSView?) {
            MKColor.textColor.withAlphaComponent(0.5).set()

            var fillFrame = cellFrame.insetBy(dx: 2, dy: 0)
            fillFrame.origin.y += 15/2
            fillFrame.size.height = 1.5
            fillFrame.fill()
        }
    }
    #endif

    /// The `ThematicBreakAttachmentCell`'s NSAttributedString representation
    internal class ThematicBreakAttachment: NSAttributedString {
        /// Initialize a `ThematicBreakAttachmentCell` and add it to an empty attributed string
        internal override convenience init() {

            #if canImport(UIKit)
            self.init(attachment: ThematicBreakAttachmentCell())
            #elseif canImport(AppKit)
            let textAttachment = NSTextAttachment()
            textAttachment.attachmentCell = ThematicBreakAttachmentCell()
            self.init(attachment: textAttachment)
            #endif
        }
    }
}
