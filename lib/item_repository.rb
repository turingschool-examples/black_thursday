class ItemRepository
  attr_reader :all

  def initialize(raw_inventory_array)
    @all = raw_inventory_array
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
end