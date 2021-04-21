# Module defined in findable.rb file

module Findable
  def find_by_id(id, collection)
    collection.find do |attribute|
      attribute.id == id
    end
  end

  def find_by_name(name, collection)
    collection.find do |attribute|
      attribute.name.downcase == name.downcase
    end
  end
  
  def find_all_by_name(name_fragment, collection)
    collection.find_all do |attribute|
      attribute.name.downcase.include?(name_fragment.downcase)
    end
  end

  def find_all_with_description(description, collection)
    collection.find_all do |attribute|
      attribute.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price, collection)
    collection.find_all do |attribute|
      attribute.unit_price == price
    end
  end

  def find_all_by_price_in_range(range, collection)
    collection.find_all do |attribute|
    (range).include?(attribute.unit_price)
    end
  end

  # This method needs to be refactored
  def find_all_by_merchant_id(merchant_id, collection)
    collection.find_all do |attribute|
      attribute.merchant_id == merchant_id
    end
  end

  def find_all_by_customer_id(customer_id, collection)
    collection.find_all do |attribute|
      attribute.customer_id == customer_id
    end
  end

  def find_all_by_status(status, collection)
    collection.find_all do |attribute|
      attribute.status == status
    end
  end

  def find_all_by_item_id(id, collection)
    collection.find_all do |attribute|
      attribute.item_id == id
    end
  end

  def find_all_by_invoice_id(id, collection)
    collection.find_all do |attribute|
      attribute.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(number, collection)
    collection.find_all do |attribute|
      attribute.credit_card_number == number
    end
  end

  def find_all_by_result(result, collection)
    collection.find_all do |attribute|
      attribute.result == result
    end
  end

  def find_all_by_first_name(name_fragment, collection)
    collection.find_all do |attribute|
      attribute.first_name.include?(name_fragment)
    end
  end

  def find_all_by_last_name(name_fragment)
    collection.find_all do |attribute|
      attribute.last_name.include?(name_fragment)
    end
  end

end
