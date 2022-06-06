module Findable

  #shared methods
  def find_by_id (id)
    @all.find {|object| object.id == id}
  end

  def find_by_name(name)
    @all.find {|object| object.name.downcase == name.downcase}
  end


#merchant methods
  def find_all_by_name(name)
    @all.find_all {|names| names.name.downcase.include?(name.downcase)}
  end


#item methods
  def find_all_by_merchant_id(input_id)
    @all.find_all {|item| item.merchant_id == input_id}
  end

  def find_all_with_description(description)
    @all.find_all {|item| item.description.downcase.include?(description.downcase)}
  end

  def find_max_id
    id_max = []
    @all.each {|item| id_max << item.id}
    id_max.max
  end

  def find_all_by_price(price)
    @all.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    items_range = []
    @all.each {|item| items_range << item if range.member?(item.unit_price)}
    items_range
  end

  #invoice methods
  def find_all_by_customer_id(id)
    @all.find_all {|invoice| invoice.customer_id == id}
  end

  def find_all_by_status(status)
    @all.find_all {|invoice| invoice.status == status}
  end

  #invoice_item_methods
  def find_all_by_item_id(id)
    @all.find_all {|invoice| invoice.item_id == id}
  end

  def find_all_by_invoice_id(id)
    @all.find_all {|invoice| invoice.invoice_id == id}
  end

end
