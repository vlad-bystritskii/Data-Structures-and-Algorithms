var testString1 = "h((e))llo(world)()"
//var testString2 = "(hello world"

func checkParentheses(_ string: String) -> Bool {
    var stack = Stack<Character>()
    
    for character in string {
        if character == "(" {
            stack.push(character)
        } else if character == ")" {
            if stack.isEmpty {
                return false
            } else {
                stack.pop()
            }
        }
    }
    return stack.isEmpty
}

checkParentheses(testString1) // should be true
//checkParentheses(testString2) // should be false
