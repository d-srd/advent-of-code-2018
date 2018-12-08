import Foundation


// dabAcCaCBAcCcaDA
// dabCBAcaDA

let input = try! String(contentsOfFile: "input.txt", encoding: .utf8)

func isCharacter(_ character: UnicodeScalar, inverseOf other: UnicodeScalar) -> Bool {
    if (UInt8(ascii: "a")...UInt8(ascii: "z")).contains(UInt8(character.value)) {
        return UInt8(character.value) - 32 == UInt8(other.value)
    } else if (UInt8(ascii: "A")...UInt8(ascii: "Z")).contains(UInt8(character.value)) {
        return UInt8(character.value) == UInt8(other.value) - 32
    } else {
        return false
    }
}

let characters = UInt8(ascii: "a")...UInt8(ascii: "z")

let result = characters
    .map { char in
        return input.unicodeScalars.filter { !areSameIgnoringCase($0, UnicodeScalar(char)) }
    }
    .map { reactor in
        return reactor
            .reduce(into: [Unicode.Scalar]()) { (accumulator, current) in
                if let last = accumulator.last, isCharacter(current, inverseOf: last) {
                    accumulator.removeLast()
                } else {
                    accumulator.append(current)
                }
            }
            .count
    }
    .min()

let eithers = input.unicodeScalars
    .reduce(into: [Unicode.Scalar]()) { (accumulator, current) in
        if let last = accumulator.last, isCharacter(current, inverseOf: last) {
            accumulator.removeLast()
        } else {
            accumulator.append(current)
        }
    }
    .count

print(eithers)
print(result)
