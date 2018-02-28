module Traversal
  def traverse(description, attribute)
    current_location = self
    while current_location.respond_to?('parent')
      current_location = current_location.parent
    end
    current_location.send(description, attribute)
  end
end
