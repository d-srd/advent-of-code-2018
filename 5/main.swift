import Foundation


// dabAcCaCBAcCcaDA
// dabCBAcaDA

enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

extension Character {
    var isLowercase: Bool {
        return "a"..."z" ~= self
    }
}

let input = "dabAcCaCBAcCcaDA"

func areSameIgnoringCase(_ c1: Character, _ c2: Character) -> Bool {
    let s1 = String(c1)
    let s2 = String(c2)
    
    return s1.lowercased() == s2.lowercased()
}

let eithers = input
    .map { char in
        char.isLowercase ? Either.left(char) : .right(char)
    }
    .reduce(into: [Either<Character, Character>]()) { (accumulator, current) in
        switch (accumulator.last, current) {
        case let (.left(l1)?, .right(r1)) where areSameIgnoringCase(l1, r1):
            accumulator.removeLast()
        case let (.right(r2)?, .left(l2)) where areSameIgnoringCase(l2, r2):
            accumulator.removeLast()
        default:
            accumulator.append(current)
        }
    }
    .map { either -> Character in
        switch either {
        case let .left(c):
            return c
        case let .right(c):
            return c
        }
    }
    .count

print(eithers)

