require_relative 'helper_methods'

class ItemRepository
  include HelperMethods
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path.to_s
    @all = Array.new
    data = CSV.parse(File.read(@file_path), headers: true) do |line|
      @all << line.to_h
    end
  end

  def find_all_with_description(description)
    result = @all.select do |line|
      line['description'].to_s.downcase.include?(description.to_s.downcase)
    end
  end

  def find_all_by_price(price)
    result = @all.select do |line|
      line['unit_price'].to_i == price.to_i
    end
  end

  def find_all_by_price_in_range(range)
    result = @all.select do |line|
      range.include?(line['unit_price'].to_i)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    result = @all.select do |line|
      line['merchant_id'].to_s.downcase == merchant_id.to_s.downcase
    end
  end

  def create(attributes)
    Item.new({
      :id => create_new_id,
      :name => attributes[:name],
      :description => attributes[:description],
      :unit_price => attributes[:unit_price],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at],
      #update value to call helper method once built. Placeholder for now.
      :merchant_id => attributes[:merchant_id]
      })
  end

  def update(id, attributes)
    result = find_by_id(id)
    result['name'] = attributes[:name]
    result['description'] = attributes[:description]
    result['unit_price'] = attributes[:unit_price]
    result['updated_at'] = Time.now
    result
  end

end
