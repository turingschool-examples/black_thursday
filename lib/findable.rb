module Findable

  def find_by_id(id)
    @merchants.select do |merchant|
      merchant.id == id
    end[0]
  end

  def find_all_by_merchant_id(merchant_id)
    @all.select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_by_name(name)
    # name = []
    @merchants.select do |row|
      # require 'pry'; binding.pry
      name << row if row.name == name
    end[0]
  end

  def find_all_by_name(search_term)
    @merchants.find_all do |merchant|
      merchant.name.upcase.include?(search_term.upcase)
    end
  end

  def find_all_with_description(description)
    @all.find_all do |row|
      row.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @all.find_all do |row|
      row.unit_price_to_dollars == price
    end
  end


  def find_all_by_price_in_range(range)
    @all.find_all do |row|
      range.include?(row.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |row|
      row.merchant_id == merchant_id
    end
  end

  def sort_by_id
    @all.sort_by do |row|
      row.id
    end
  end

  def delete(id)
    @all.delete(find_by_id(id)[0])
  end
end
