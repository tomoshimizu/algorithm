import UIKit
import Darwin

/*
 We are given a string S representing a phone number, which we would like to reformat. String S consists of N characters: digits, spaces, and/or dashes. It contains at least two digits.
 
 Spaces and dashes in string S can be ignored. We want to reformat the given phone number is such a way that the digits are grouped in blocks of length three, separated by single dashes. If necessary, the final block or the last two blocks can be of length two.
 
 For example:
 
 S = "00-44   48 5555 8361" should become
     "004-448-555-583-61"
 
 Assume:
 - S consists only of digits (0-9), spaces, and/or dashses (-)
 - S containts at least two digits
 
 Translate:
 
 Would like to reformat a phone number string so that:
 - every third char is a "-"
 - spaces and dashes don't matter
 - if the block ends in anything other than -xxx or -xx reformat to a block of two like xx-xx (not obvious)
 
 */

func solution(_ S : String) -> String {
    var newStr = S
    
    // 数値以外の文字を除去
    let delChar: Set<Character> = [" ", "-"]
    newStr.removeAll(where: { delChar.contains($0) })
    
    // 3文字以下の場合はそのまま返す
    guard newStr.count > 3 else { return newStr }
    
    var answer: String = ""
    for (idx, c) in newStr.enumerated() {
        if (idx + 1) % 3 == 0 && idx != newStr.count - 1 {
            // 3で割れる、かつ最後でない場合
            answer = answer + "\(c)-"
        } else {
            answer = answer + "\(c)"
        }
    }
    
    // 最後から2番目が「-」の場合は一つ左にずらす
    var chars = Array(answer)
    if chars[chars.count - 2] == "-" {
        chars[chars.count - 2] = chars[chars.count - 3]
        chars[chars.count - 3] = "-"
    }
    
    answer = String(chars)
    
    return answer
}

solution("123456789")           // 123-456-789
solution("555372654")           // 555-372-654
solution("0 - 22 1985--324")    // 022-198-53-24

// Edge cases
solution("01")                          // 01
solution("012")                         // 012
solution("0123")                        // 01-23
solution("0123       444")              // 012-34-44
solution("------0123       444")        // 012-34-44
