import Foundation

extension Character {
    var isLowercase: Bool {
        return "a"..."z" ~= self
    }
}

let input = try! String(contentsOfFile: "input.txt", encoding: .utf8)

func areSameIgnoringCase(_ c1: Character, _ c2: Character) -> Bool {
    let s1 = String(c1)
    let s2 = String(c2)
    
    return s1.lowercased() == s2.lowercased()
}

let eithers = input
    .reduce(into: [Character]()) { (accumulator, current) in
        if let last = accumulator.last, areSameIgnoringCase(last, current) {
            accumulator.removeLast()
        } else {
            accumulator.append(current)
        }
    }
    .count

print(eithers)

