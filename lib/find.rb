require_relative 'require_store'

module Find
  def find_by_id(id)
    all.find do |individual|
      individual.id == id
    end
  end

  def find_by_name(name)
    all.find do |individual|
      individual.name.casecmp?(name)
    end
  end

  def find_all_by_name(name)
    all.find_all do |individual|
      individual.name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |individual|
      individual.merchant_id == merch_id
    end
  end

  def find_all_with_description(descrip)
    all.find_all do |singular|
      singular.description.downcase.include?(descrip.downcase)
    end
  end

  def find_all_by_price(price)
    all.find_all do |singular|
      singular.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |singular|
      singular.unit_price.between?(range.first, range.last)
    end
  end

  def find_all_by_customer_id(id)
    all.find_all do |singular|
      singular.customer_id == id
    end
  end

  def find_all_by_status(status)
    all.find_all do |singular|
      singular.status == status
    end
  end

  def find_all_by_item_id(item_id)
    all.find_all do |singular|
      singular.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |singular|
      singular.invoice_id == invoice_id
    end
  end

  def find_all_by_first_name(name_frag)
    all.find_all do |singular|
     singular.first_name.downcase.include?(name_frag.downcase)
    end
  end

  def find_all_by_last_name(name_frag)
    all.find_all do |singular|
     singular.last_name.downcase.include?(name_frag.downcase)
    end
  end

  def find_all_by_credit_card_number(cc_num)
    all.find_all do |singular|
      singular.credit_card_number == cc_num
    end
  end

  def find_all_by_result(result)
    all.find_all do |singular|
      singular.result == result
    end
  end
end