require 'csv'
require 'htmlentities'
require_relative 'item'

class ItemRepository
  attr_reader :all, :parent

  def initialize(file_path, parent)
    @all = parse_items(file_path)
    @parent = parent
  end

  def parse_items(file_path)
    items_data = []
    CSV.foreach(file_path, headers:true) do |row|
      items_data << Item.new({:id => row['id'].to_i, 
                              :name => row['name'],
                              :description => HTMLEntities.new.decode(row['description']),
                              :unit_price => BigDecimal.new(row['unit_price']),
                              :merchant_id => row['merchant_id'].to_i,
                              :created_at => Time.parse(row['updated_at']),
                              :updated_at => Time.parse(row['created_at'])
                            },
                            self)
    end
    items_data
  end

  def find_by_id(desired_id)
    all.find { |x| x.id.eql?(desired_id) }
  end

  def find_by_name(desired_name)
    all.find { |x| x.name.downcase.eql?(desired_name.downcase) }
  end

  def find_all_by_description(fragment)
    response = all.find_all { |x| x.description.downcase.include?(fragment.downcase) }
  end

  def find_all_by_price(desired_price)
    response = all.find_all { |x| convert_to_dollar(x.unit_price).eql?(desired_price) }
  end

  def find_all_by_price_in_range(desired_range)
    values   = desired_range.step(0.01).to_a
    response = all.find_all { |x| values.include?(convert_to_dollar(x.unit_price)) }
  end

  def convert_to_dollar(big_decimal)
    sprintf('%05.2f', (big_decimal/100)).to_f
  end

  def find_all_by_merchant_id(desired_merchant_id)
    all.find_all { |x| x.merchant_id.eql?(desired_merchant_id) }
  end

  def find_merchant_by_merchant_id(merchant_id)
    parent.find_merchant_by_merchant_id(merchant_id)
  end
end