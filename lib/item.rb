class Item
  @@all         = []

  attr_reader :id, :name, :description, :unit_price,  :created_at, :updated_at, :merchant_id
  def initialize(data)
    @id           = data[:id]
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = data[:unit_price]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @merchant_id  = data[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def self.all
    @@all
  end

  def self.add_from_csv(file)
    csv = $csv
    @@all = csv.map do |row|
      Item.new(row)
    end
  end

  def self.find_by_id(id)
    csv = $csv
    @@all.find_all do |item|
      item.id == id
    end.pop 
  end


end
