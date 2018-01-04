def dfs(adj_matrix, source, terminal)
  node_stack = [source]

  loop do
    current_node = node_stack.pop
    return false if current_node == nil
    return true if current_node == terminal

    children = (0..adj_matrix.length-1).to_a.select do |i|
      adj_matrix[current_node][i] == 1
    end

    node_stack += children
  end
end

adj_matrix = [
  [1, 0, 1, 0, 1, 0],
  [0, 0, 1, 0, 0, 1],
  [0, 0, 0, 1, 0, 0],
  [0, 1, 0, 0, 1, 1],
  [0, 0, 1, 0, 0, 0],
  [0, 0, 1, 1, 0, 0]
]

p dfs(adj_matrix, 0, 5)
