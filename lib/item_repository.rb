class ItemRepository
  def initialize(data)
    @item_data = CSV.open(data, headers: true, header_converters: :symbol)
    @collection = []
  end

  def items
    @item_data.each do |row|
      @collection << Item.new({id: "#{row[:id]}",
                              name: "#{row[:name]}",
                              description: "#{row[:description]}",
                              unit_price: "#{row[:unit_price]}",
                              merchant_id: "#{row[:merchant_id]}",
                              created_at: "#{row[:created_at]}",
                              updated_at: "#{row[:updated_at]}"})
    end
    @collection
  end


end
