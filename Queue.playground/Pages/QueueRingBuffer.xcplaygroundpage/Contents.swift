public struct QueueRingBuffer<T>: Queue {
    private var ringBuffer: RingBuffer<T>

    public init(count: Int) {
        ringBuffer = RingBuffer(count: count)
    }

    public var isEmpty: Bool {
        return ringBuffer.isEmpty
    }

    public var peek: T? {
        return ringBuffer.first
    }

    public mutating func enqueue(_ value: T) -> Bool {
        ringBuffer.write(value)
    }

    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
}

var queue = QueueRingBuffer<String>(count: 10)
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue
queue.dequeue()
queue
queue.peek
