struct Array<Element>
struct Dictionary<Key, Value> where Key : Hashable
func min<T>(_ x: T, _ y: T) -> T where T : Comparable
func min<T: Comparable>(_ x: T, _ y: T) -> T
