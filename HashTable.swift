import Cocoa
import Foundation

public struct HashTable<Key: Hashable, Value>{
    private typealias Element = (key: Key, value:Value)
    private typealias Bucket = [Element]
    private var buckets:[Bucket]
    
    private(set) public var count = 0
    
    public var isEmpty:Bool {return count == 0}
    
    public init(capacity: Int){
        assert(capacity > 0)
        buckets =Array<Bucket>(repeatElement([], count: capacity))
    }
}