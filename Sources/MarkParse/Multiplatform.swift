//
//  File.swift
//  
//
//  Created by Diogo Silva on 01/20/21.
//

#if canImport(UIKit)

import UIKit
public typealias MKFont = UIFont
public typealias MKColor = UIColor
public typealias MKUnderlineStyle = NSUnderlineStyle
public typealias MKParagraphStyle = NSParagraphStyle
public typealias MKMutableParagraphStyle = NSMutableParagraphStyle
//public typealias MKTextAttachmentCell = NSTextAttachmentCell
public typealias MKTextTab = NSTextTab
public typealias MKTextContainer = NSTextContainer
public typealias MKTextAttachment = NSTextAttachment

extension UIFontDescriptor.SymbolicTraits {
    static let bold = traitBold
    static let italic = traitItalic
}

extension UIColor {
    public static let textColor = UIColor.darkText

    public static let backgroundColor: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return UIColor.white
        }
    }()
}

#elseif canImport(AppKit)

import AppKit
public typealias MKFont = NSFont
public typealias MKColor = NSColor
public typealias MKUnderlineStyle = NSUnderlineStyle
public typealias MKParagraphStyle = NSParagraphStyle
public typealias MKMutableParagraphStyle = NSMutableParagraphStyle
public typealias MKTextAttachmentCell = NSTextAttachmentCell
public typealias MKTextTab = NSTextTab
public typealias MKTextContainer = NSTextContainer
public typealias MKTextAttachment = NSTextAttachment

extension NSColor {
    public static let backgroundColor = NSColor.windowBackgroundColor
}

#else

//fatalError("Unsupported platform: currently, MarkParse only works with UIKit & Appkit")

#endif
