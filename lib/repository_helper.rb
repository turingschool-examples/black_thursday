module RepositoryHelper

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    matched_price = @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_by_id(id)
    @all.find do|object|
      id == object.id
    end
  end

  def find_by_name(name)
    @all.find do |object|
      object.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |object|
      object.name.downcase.include?(name.downcase)
    end
  end

  def find_highest_id
    @all.max_by do |object|
      object.id
    end
  end
  
  def create_id
    find_highest_id.id.to_i + 1
  end

  def delete(id)
     @all = @all.reject do |object|
    object.id == id
    end
  end

end
