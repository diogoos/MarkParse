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
public typealias MKTextTab = NSTextTab

extension UIFontDescriptor.SymbolicTraits {
    static let bold = traitBold
    static let italic = traitItalic
}

extension UIColor {
    public static let textColor: UIColor = {
        if #available(iOS 13.0, tvOS 13.0, *) {
            return UIColor.label
        } else {
            #if os(tvOS)
            return UIColor.white
            #else
            return UIColor.darkText
            #endif
        }
    }()

    public static let windowBackgroundColor: UIColor = UIColor.gray
}

#elseif canImport(AppKit)

import AppKit
public typealias MKFont = NSFont
public typealias MKColor = NSColor
public typealias MKUnderlineStyle = NSUnderlineStyle

public typealias MKParagraphStyle = NSParagraphStyle
public typealias MKMutableParagraphStyle = NSMutableParagraphStyle
public typealias MKTextTab = NSTextTab

#else

// MarkParse is only extensively tested with MacOS and iOS
// It should also be compatible with tvOS
// WatchOS support is not available.

#endif
