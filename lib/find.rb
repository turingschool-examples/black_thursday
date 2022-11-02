module Find
  def all
    if @merchants != [] && @merchants != nil
      return @merchants
    elsif @items != [] && @items != nil
      return @items
    else
      return @invoices
    end
  end

  def find_by_id(id)
    if @merchants != [] && @merchants != nil
      merchants.find do |merchant|
        merchant.id == id
      end
    elsif @items != [] && @items != nil
      items.find do |item|
        item.id == id
      end
    else
      invoices.find do |invoice|
        invoice.id == id
      end
    end
  end

  def find_by_name(name)
    if @merchants != [] && @merchants != nil
      merchants.find do |merchant|
        merchant.name.casecmp?(name)
      end
    elsif @items != [] && @items != nil
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
    elsif @items != [] && @items != nil
      items.find_all do |item|
        item.name.downcase.include?(name.downcase)
      end
    end
  end

  def find_all_by_merchant_id(merch_id)
    if @items != [] && @items != nil
      @items.find_all do |item|
        item.merchant_id == merch_id
      end
    else
      @invoices.find_all do |invoice|
        invoice.merchant_id == merch_id
      end
    end
  end
end