//
//  PurLogColor.swift
//  PurLog
//
//  Created by Grant Espanet on 8/19/24.
//

import Foundation

public enum PurLogTextColor: String {
    // Regular Colors
    case BLACK = "\u{001B}[0;30m"
    case RED = "\u{001B}[0;31m"
    case GREEN = "\u{001B}[0;32m"
    case YELLOW = "\u{001B}[0;33m"
    case BLUE = "\u{001B}[0;34m"
    case MAGENTA = "\u{001B}[0;35m"
    case CYAN = "\u{001B}[0;36m"
    case WHITE = "\u{001B}[0;37m"
    
    // Bright Colors
    case BRIGHT_BLACK = "\u{001B}[1;30m"
    case BRIGHT_RED = "\u{001B}[1;31m"
    case BRIGHT_GREEN = "\u{001B}[1;32m"
    case BRIGHT_YELLOW = "\u{001B}[1;33m"
    case BRIGHT_BLUE = "\u{001B}[1;34m"
    case BRIGHT_MAGENTA = "\u{001B}[1;35m"
    case BRIGHT_CYAN = "\u{001B}[1;36m"
    case BRIGHT_WHITE = "\u{001B}[1;37m"
    
    // Dim Colors
    case DIM_BLACK = "\u{001B}[2;30m"
    case DIM_RED = "\u{001B}[2;31m"
    case DIM_GREEN = "\u{001B}[2;32m"
    case DIM_YELLOW = "\u{001B}[2;33m"
    case DIM_BLUE = "\u{001B}[2;34m"
    case DIM_MAGENTA = "\u{001B}[2;35m"
    case DIM_CYAN = "\u{001B}[2;36m"
    case DIM_WHITE = "\u{001B}[2;37m"
}
