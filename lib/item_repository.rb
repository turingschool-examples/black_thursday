class ItemRepository

  def initialize(csv_data, sales_engine)
    @all_item_data = csv_data
    @sales_engine = sales_engine
  end
end
