import Cocoa
import Foundation

// Graphs - have  vertices(nodes) and edges(connections)
// Graph Variations - multidirectional , one-directional , DAG (directed acylic graph)
// DAG - directional edges , no way to go back to the starting node

// --- Graph Examples ----
// Data Models , State Machine Diagrams

// --- Graph Implementations ----
//Adjacency List --> each vertex has a list of what other vertices that originate from it (*A* -> B , C , D) (*B* -> L , M ,N)
// Reading of adjancency lists is expensive (no way to directly access a vertex)
//Adjacency Matrix --> the vertices and weight values are stored in a matrix , where the weight is stored between the vertecies , no weight -> no edge
//! Adding new vertices is expensive as more memmory needs to allocated to the matrix 


public struct Edge<T>: Equatable where T: Equatable, T: Hashable {

    public let from: Vertex<T>
    public let to: Vertex<T>
    public let weight: Double?
}

public struct Vertex<T>: Equatable where T: Equatable, T:Hashable{
    public var data:T
    public var index:Int
}
