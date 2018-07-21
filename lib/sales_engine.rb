require_relative "./file_loader"

class SalesEngine
  include FileLoader
  attr_reader :content
  def initialize(content)
    @content = content
  end

  def self.from_csv(content)
    
  end
end
