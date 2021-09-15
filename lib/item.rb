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
    #
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
  def self.find_by_name(name)
    csv = $csv
    @@all.find_all do |item|
      item.name == name
    end
  end
  def self.find_all_with_description(description)
    csv = $csv
    @@all.find_all do |item|
      item.description == description
    end
  end
  def self.find_all_by_price(unit_price)
    csv = $csv
    @@all.find_all do |item|
      item.unit_price == unit_price
    end
  end
  def self.find_all_by_merchant_id(merchant_id)
    csv = $csv
    @@all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end
  def self.create(attributes)
    id_max = @@all.max_by {|item| item.id}
    attributes[:id] = id_max.id + 1
    new = self.new(attributes)
    @@all.push(new)
  end
end
