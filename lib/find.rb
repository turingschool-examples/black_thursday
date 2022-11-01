module Find
  def all
    if @merchants != [] && @merchants != nil
      return @merchants
    else
      return @items
    end
  end

  def find_by_id(id)
    if @merchants != [] && @merchants != nil
      merchants.find do |merchant|
        merchant.id == id
      end
    else
      items.find do |item|
        item.id == id
      end
    end
  end

  def find_by_name(name)
    if @merchants != [] && @merchants != nil
      merchants.find do |merchant|
        merchant.name.casecmp?(name)
      end
    else
      items.find do |item|
        item.name.casecmp?(name)
      end
    end
  end

  def find_all_by_name(name)
    if @merchants != [] && @merchants != nil
      merchants.find_all do |merchant|
        merchant.name.downcase.include?(name.downcase)
      end
    else
      items.find_all do |item|
        item.name.downcase.include?(name.downcase)
      end
    end
  end
end