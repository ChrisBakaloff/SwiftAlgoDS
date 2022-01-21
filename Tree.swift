import Cocoa
import Foundation

public class TreeNode<T>{
    //TreeNode is part of the Tree Data Structure (general value tree)
    //Trees also include binary trees (Where every node can have only two children)
    //Other tree types also exist
    public var value: T
    public var children = [TreeNode<T>]()
    public var parent:TreeNode<T>?
    
    public init(value: T){
        self.value = value
    }
    ///Add a child node to a tree node
    public func addChild(_ node: TreeNode<T>){
        children.append(node)
        node.parent = self
    }
}

extension TreeNode where T: Equatable {
    ///Recursively search the tree and return the node or nil
    func search(_ value: T) -> TreeNode?{
        if value == self.value{
            return self
        }
        for child in self.children {
            if let found = child.search(value){
                return found
            }
        }
        return nil
    }
}