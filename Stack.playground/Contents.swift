public func example(of description: String, action: () -> Void) {
  print("\n--- Example of:", description, "---")
  action()
}

public struct Stack<Element> {

    public var isEmpty: Bool {
        peek() == nil
    }

    private var storage: [Element] = []

    public init(_ storage: [Element] = []) {
        self.storage = storage
    }

    public mutating func push(_ element: Element) {
        storage.append(element)
    }

    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }

    public func peek() -> Element? {
        storage.last
    }
}

extension Stack: Sendable where Element: Sendable {}

extension Stack: CustomDebugStringConvertible {
  public var debugDescription: String {
    """
    ----top----
    \(storage.map { "\($0)" }.reversed().joined(separator:
    "\n"))
    -----------
    """
  }
}

extension Stack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    storage = elements
  }
}

example(of: "using a stack") {
  var stack = Stack<Int>()
  stack.push(1)
  stack.push(2)
  stack.push(3)
  stack.push(4)
  print(stack)

  if let poppedElement = stack.pop() {
    assert(4 == poppedElement)
    print("Popped: \(poppedElement)")
  }
}

example(of: "initializing a stack from an array") {
  let array = ["A", "B", "C", "D"]
  var stack = Stack(array)
  print(stack)
  stack.pop()
}

example(of: "initializing a stack from an array literal") {
  var stack: Stack = [1.0, 2.0, 3.0, 4.0]
  print(stack)
  stack.pop()
}

example(of: "sendability") { @MainActor in // 1.
  // 2.
  let task = Task.detached {
    return Stack([1])
  }
  // 3.
  Task.detached {
    let value = await task.value
    print(value)
  }
}

example(of: "Challenges") {
    func printInRevers<T>(_ array: [T]) {
        var stack = Stack<T>()
        for value in array {
            stack.push(value)
        }

        while let value = stack.pop() {
            print(value)
        }
    }

    func checkBalancedParentheses(_ string: String) -> Bool {
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
}
