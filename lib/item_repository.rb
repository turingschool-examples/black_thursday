class ItemRepository
  attr_reader :all
  
  def initialize(path)
    @path = path
    @all = generate
  end

  def generate
    CSV.readlines(@path).drop(1).map do |line|
      id,name,description,unit_price,merchant_id,created_at,updated_at = line
      Item.new({
          :id => id.to_i,
          :name => name,
          :description => description,
          :unit_price => unit_price.to_f,
          :merchant_id => merchant_id.to_i
          })
    end
  end
end