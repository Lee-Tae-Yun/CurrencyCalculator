//
//  FavoriteCurrency+CoreDataProperties.swift
//  CurrencyCalculatorApp
//
//  Created by 이태윤 on 7/12/25.
//
//

import Foundation
import CoreData


extension FavoriteCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCurrency> {
        return NSFetchRequest<FavoriteCurrency>(entityName: "FavoriteCurrency")
    }

    @NSManaged public var code: String?

}

extension FavoriteCurrency : Identifiable {

}
