//
//  Constants.swift
//  MovieApp
//
//  Created by Марина Рябчун on 04.06.2023.
//

import UIKit

enum Constants{
    enum Colors{
        static var black: UIColor?{
            UIColor(named: "Black")
        }
        static var defaultColor: UIColor?{
            UIColor(named: "Default")
        }
        static var accent2: UIColor?{
            UIColor(named: "White")
        }
        static var accent3: UIColor?{
            UIColor(named: "Yellow")
        }
    }
    enum Fonts{
        static var header1: UIFont?{
            UIFont(name: "Graphik-Semibold", size: 26)
        }
        static var header2: UIFont?{
            UIFont(name: "Graphik-Medium", size: 17)
        }
        static var mainBody: UIFont?{
            UIFont(name: "Graphik-Regular", size: 15)
        }
        static var smallText: UIFont?{
            UIFont(name: "Graphik-Regular", size: 13)
        }
    }
    enum Image {
        static let startImage = "Start"
        static let star = "Star"
    }
}


