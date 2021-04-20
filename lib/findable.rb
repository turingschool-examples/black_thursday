# Module defined in findable.rb file

#testing with ItemRepo
#CONFIRM STYLE GUIDE AROUND SPACEING
module Findable #confirm this needs the 'able'
  def find_by_id(id, collection)                            #ItemRepo - PASSED
    collection.find do |attribute|                          #MerchantRepo - PASSED
      attribute.id == id
    end
  end

  def find_by_name(name, collection)                       #ItemRepo - PASSED
    collection.find do |attribute|                         #MerchantRepo - PASSED
      attribute.name.downcase == name.downcase
    end
  end
#ISSUE WITH THIS METHOD - RETEST
  def find_all_by_name(name_fragment, collection)         #MerchantRepo
    collection.find_all do |attribute|
      attribute.name.downcase.include?(name_fragment.downcase)
    end
  end

  def find_all_with_description(description, collection)   #ItemRepo - PASSED
    collection.find_all do |attribute|
      attribute.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price, collection)                 #ItemRepo - PASSED
    collection.find_all do |attribute|
      attribute.unit_price == price
    end
  end

  def find_all_by_price_in_range(range, collection)       #ItemRepo - PASSED
    collection.find_all do |attribute|
    (range).include?(attribute.unit_price)
    end
  end

  # This method needs to be refactored
  def find_all_by_merchant_id(merchant_id, collection)   #ItemRepo - PASSED
    collection.find_all do |attribute|
      attribute.merchant_id == merchant_id
    end
  end

end
