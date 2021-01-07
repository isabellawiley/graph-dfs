require "set"

def is_path(graph, vertex_a, vertex_b, visited = Set.new)
  visited.add(vertex_a)
  idx = 0

  while idx < graph[vertex_a].length
    vertex = graph[vertex_a][idx]
    idx += 1
    return true if vertex == vertex_b
    next if visited.include?(vertex)
    return true if is_path(graph, vertex, vertex_b, visited)
  end

  false
end

if __FILE__ == $PROGRAM_NAME
  graph = {
    jan: [:john, :jambaby],
    john: [:carl],
    jambaby: [],
    carl: [:jambaby],
    dave: []
  }
  
  puts "Expecting: true"
  puts is_path(graph, :jan, :carl)

  puts

  puts "Expecting: false"
  puts is_path(graph, :jan, :dave)

  # Don't forget to add your own!
  puts "Expecting: false"
  puts is_path(graph, :dave, :jambaby)

  puts ""

  puts "Expecting: false"
  puts is_path(graph, :jan, :jan)

  graph = {
    jan: [:john, :jambaby],
    john: [:carl],
    jambaby: [],
    carl: [:jambaby, :dave],
    dave: [:jan],
    mittens: []
  }

  puts ""

  puts "Expecting: true"
  puts is_path(graph, :jan, :jan)

  puts ""

  puts "Expecting: false"
  puts is_path(graph, :jan, :mittens)

  graph = {
    jan: [:john, :jambaby, :malala],
    john: [:carl],
    jambaby: [],
    carl: [:jambaby, :dave, :martin],
    dave: [:jan],
    mittens: [],
    martin: [:mittens],
    malala: [:dave, :carl, :martin, :pirate],
    pirate: [:shiba, :inu],
    shiba: [],
    inu: []
  }

  puts ""

  puts "Expecting: true"
  puts is_path(graph, :carl, :inu)
end

# Please add your pseudocode to this file
###################################################################################################
 # function is_path(graph, vertex_a, vertex_b, visited):
 #  return true if vertex_b exists in vertex_a adjacency list
 # 
 #  add vertex_a to visited
 # 
 #  iterate over each vertex in vertex_a adjacency list:
 #    if vertex is not in visited:
 #      initialize variable result to value returned from is_path(graph, vertex, vertex_b, visited)
 #      return true if result is true
 # 
 #  return false
###################################################################################################

# And a written explanation of your solution
###################################################################################################
 # I started by thinking of my base case, which is that the algorithm should return true if 
 # vertex B is in vertex A's adjacency list, an O(n) operation. I'm not checking for inclusion in 
 # the other direction from B to A because this is a directed graph. Since it is possible for there 
 # to be loops in the graph, I need to also store a list of vertices that have been visited. This 
 # prevents me from creating a stack overflow. 
 # 
 # I chose a Set instead of an Array because checking if a vertex
 # has been visited already would then have an O(1) lookup time, whereas an Array would be O(n). 
 # The trade-off is that the Set takes up more space in memory. 
 # 
 # I chose to iterate over the adjacency list using a loop that can be broken out of, as opposed
 # to one that offers no breaking mechanism. I did this because I want iteration to stop as soon
 # as a path has been found. At that time I can simply return true.
 # 
 # On each iteration, I check if the vertex in the adjacency list has not been visited. If it hasn't
 # I recurse with the current vertex that's being iterated over, vertex B, and the  
 # visited Set. If the recursive call returns true, that value will travel up the stack and
 # continue returning true until it reaches the top and the whole method returns true.
 # 
 # If all reachable vertices are visited and vertex B is not found, the algorithm will return
 # false once it exits the iteration in each frame.
 #
 # I could optimize this algorithm by not checking the adjacency list as the base case, and instead
 # check if vertex A is vertex B. However, I'd have to make additional changes to my code to ensure
 # that it does not return true for the following case: finding a path from vertex A back to itself.
 # I ran out of time, but if I had more time I would do that. That would provide a time complexity of
 # O(n).
###################################################################################################
