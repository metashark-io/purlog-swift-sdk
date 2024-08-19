//
//  PurLogBackgroundColor.swift
//  PurLog
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

public enum PurLogBackgroundColor: String {
    // Regular Colors
    case BLACK = "\u{001B}[40m"
    case RED = "\u{001B}[41m"
    case GREEN = "\u{001B}[42m"
    case YELLOW = "\u{001B}[43m"
    case BLUE = "\u{001B}[44m"
    case MAGENTA = "\u{001B}[45m"
    case CYAN = "\u{001B}[46m"
    case WHITE = "\u{001B}[47m"
    
    // Bright Background Colors
    case BRIGHT_BLACK = "\u{001B}[100m"
    case BRIGHT_RED = "\u{001B}[101m"
    case BRIGHT_GREEN = "\u{001B}[102m"
    case BRIGHT_YELLOW = "\u{001B}[103m"
    case BRIGHT_BLUE = "\u{001B}[104m"
    case BRIGHT_MAGENTA = "\u{001B}[105m"
    case BRIGHT_CYAN = "\u{001B}[106m"
    case BRIGHT_WHITE = "\u{001B}[107m"
}
