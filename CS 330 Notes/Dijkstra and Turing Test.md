# CS 330 Notes | 9 March 2020
## Chapter 4: Pathfinding, continued
### Dijkstra's: Comments
- Performance:
  - *O(nm)*, where *n* = nodes and *m* = connections per node
  - In worst case *m* = *n*, hence *O(n<sup>2</sup>)*, but...
  - ... in such densely connected graphs, goal reached quickly
- Weaknesses:
  - Searches entire graph to build all shortest paths
  - ... rather than focusing on path from start to goal
  - Nodes visited but not on path from start to goal called "fill"

### Turing test, in general
- Compare computer behavior to human behavior
- Method
  - Subject Matter Experts observe behavior
  - Identify behavioras human- or computer-generated
- Comments
  - Suitable especially for validating human behavior models
  - Inability to reliably distinguish human from computer suggests computer-generated behavior is realistic and valid
  - Proportion of correct identifications should be statistically tested

### Turing test, A* Pathfinding
- Compare A* routes to human routes
- Method
  - CS 330 students observe routes in McKenna MOUT
  - Identify routes as human- or A*-generated
- Comments
  - 8x routes, 0-8 human-generated, 0-8 A*-generated
  - Inability to reliably distinguish human from A*
  - Proportion of correct identifications should be statistically tested
