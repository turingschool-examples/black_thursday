class ItemRepository
  attr_reader :all
  
  def initialize(csv_file)
    @csv_file = csv_file
    @all = []
  end
end