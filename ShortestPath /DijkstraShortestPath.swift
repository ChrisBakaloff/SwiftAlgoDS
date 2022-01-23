import Foundation

open class Vert {
    open var identifier: String
    open var neighbours: [(Vert, Double)] = []
    open var pathLengthFromStart = Double.infinity
    open var pathVerticesFromStart: [Vert] = []
    public init(identifier: String) {
        self.identifier = identifier
    }
    open func clearCache() {
        pathLengthFromStart = Double.infinity
        pathVerticesFromStart = []
    }
}

extension Vert: Hashable {
    open var hashValue: Int {
        return identifier.hashValue
    }
}

extension Vert: Equatable {
    public static func ==(lhs: Vert, rhs: Vert) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}



public class Dijkstra {
    private var totalVertices: Set<Vert>
    
    public init(vertices: Set<Vert>){
        totalVertices = vertices
    }
    
    private func clearCache(){
        totalVertices.forEach{$0.clearCache()}
    }
    
    public func shortestPathSearch(from startVertex: Vert){
        clearCache()
        startVertex.pathLengthFromStart = 0
        startVertex.pathVerticesFromStart.append(startVertex)
        
        var currentVertex: Vert? = startVertex
        
        while let vertex = currentVertex {
            totalVertices.remove(vertex)
            let filteredNeighbours = vertex.neighbours.filter {totalVertices .contains($0.0)}
            
            for neighbour in filteredNeighbours {
                let neighbourVertex = neighbour.0
                let weight = neighbour.1
                
                let theoreticalWeight = vertex.pathLengthFromStart + weight
                
                if theoreticalWeight < neighbourVertex.pathLengthFromStart {
                    neighbourVertex.pathLengthFromStart = theoreticalWeight
                    neighbourVertex.pathVerticesFromStart = vertex.pathVerticesFromStart
                    neighbourVertex.pathVerticesFromStart.append(neighbourVertex)
                }
            }
            
            if totalVertices.isEmpty {
                currentVertex = nil
                break
            }
            currentVertex = totalVertices.min {$0.pathLengthFromStart < $1.pathLengthFromStart}
        }
    }
}



var vertices: Set<Vert> = Set()

func createVertices(number num: Int){
    for i in 0..<num {
        let vertex = Vert(identifier: "\(i)")
        vertices.insert(vertex)
    }
}


func connectVertices(){
    for vertex in vertices {
        let randomEdgesCount = arc4random_uniform(4) + 1
        for _ in 0..<randomEdgesCount {
            let rand_weight = Double(arc4random_uniform(10))
            let neighbVertex = randomVert(except: vertex)
            if vertex.neighbours.contains(where: {$0.0 == neighbVertex}) {
                continue
            }
            
            let n1 = (neighbVertex,rand_weight)
            let n2 = (vertex, rand_weight)
            vertex.neighbours.append(n1)
            neighbVertex.neighbours.append(n2)
        }
    }
}

func randomVert(except vertex: Vert) -> Vert {
    var newSet = vertices
    newSet.remove(vertex)
    let offset = Int(arc4random_uniform(UInt32(newSet.count)))
    let index = newSet.index(newSet.startIndex , offsetBy: offset)
    return newSet[index]
}
func randomVert() -> Vert {
    let offset = Int(arc4random_uniform(UInt32(vertices.count)))
    let index = vertices.index(vertices.startIndex, offsetBy: offset)
    return vertices[index]
}

//MARK: Dijkstra Shortest Path
createVertices(number: 15)
connectVertices()

let dijkastra = Dijkstra(vertices: vertices)
let startVertex = randomVert()
let startTime = Date()

dijkastra.shortestPathSearch(from: startVertex)

let endTime = Date()

print("calculation time is = \((endTime.timeIntervalSince(startTime))) sec")

//printing results
let destinationVertex = randomVert(except: startVertex)
print(destinationVertex.pathLengthFromStart)
var pathVerticesFromStartString: [String] = []
for vertex in destinationVertex.pathVerticesFromStart {
   pathVerticesFromStartString.append(vertex.identifier)
}

print(pathVerticesFromStartString.joined(separator: "->"))
