require_relative './item'
require_relative './repository'

class ItemRepository < Repository

  def initialize(filepath)
    super()
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |data|
      @data << Item.new(data)
    end
  end


end
