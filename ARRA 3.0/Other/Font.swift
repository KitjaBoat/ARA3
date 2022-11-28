//
//  Font.swift
//  ARRA 3.0
//
//  Created by ARSOFT on 25/11/2565 BE.
//

import Foundation
import UIKit


enum Font: String {
    case First = "Prompt"
}

enum FontStyle: String {
    case Light = "Light"
    case Regular = "Regular"
    case Medium = "Medium"
    case SemiBold = "SemiBold"
    case Bold = "Bold"
}

class FontManager {
    
    static func getFont(
        fontName: Font = .First,
        style: FontStyle,
        size: CGFloat
    ) -> UIFont? {
        return UIFont(name: "\(fontName.rawValue)-\(style.rawValue)", size: size)
    }
    
    static func getFontForTitleBold(
        fontName: Font = .First,
        size: CGFloat? = nil
    ) -> UIFont? {
        return getFont(fontName: fontName, style: .Bold, size: size ?? 20)
    }
    
    static func getFontForTitle(
        fontName: Font = .First,
        size: CGFloat? = nil
    ) -> UIFont? {
        return getFont(fontName: fontName, style: .SemiBold, size: size ?? 20)
    }
    
    static func getFontForSubtitle(
        fontName: Font = .First,
        size: CGFloat? = nil
    ) -> UIFont? {
        return getFont(fontName: fontName, style: .Medium, size: size ?? 18)
    }
    
    static func getFontForDetail(
        fontName: Font = .First,
        size: CGFloat? = nil
    ) -> UIFont? {
        return getFont(fontName: fontName, style: .Regular, size: size ?? 16)
    }
    
    static func getFontForSubdetail(
        fontName: Font = .First,
        size: CGFloat? = nil
    ) -> UIFont? {
        return getFont(fontName: fontName, style: .Light, size: size ?? 14)
    }
}
