require "bigdecimal"

class ItemRepository
  attr_reader :all

  def initialize(items_path)
    @all = []

    CSV.foreach(items_path,     headers: true,     header_converters: :symbol) do |row|
      require "pry"

      binding.pry
      @all << Item.new({:id => row[:id], :name => row[:name]})
    end
  end
end
