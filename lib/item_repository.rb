class ItemRepository
  def initialize(data)
    @item_data = CSV.open(data, headers: true, header_converters: :symbol)
    @collection = []
  end

  
end
