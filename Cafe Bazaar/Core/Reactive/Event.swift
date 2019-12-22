//
//  Event.swift
//  Cafe Bazaar
//
//  Created by Farshad Jahanmanesh on 12/18/19.
//  Copyright © 2019 Farshad Jahanmanesh. All rights reserved.
//

import Foundation
public enum Event<Element> {
    /// Next element is produced.
    case next(Element)

    /// Sequence terminated with an error.
    case error(Swift.Error)

    /// Sequence completed successfully.
    case completed
}
