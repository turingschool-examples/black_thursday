require_relative "./file_loader"

class SalesEngine
  include FileLoader
  def initialize(content)
    @content = content
  end
  
end
