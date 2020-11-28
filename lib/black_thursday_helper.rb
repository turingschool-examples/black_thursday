require 'CSV'
require 'pry'
require 'time'
module BlackThursdayHelper

  def all
    @collections
  end

  def find_by_id(id)
    @collections.find do |object|
     object.id == id
   end
  end

  def find_by_name(name)
    @collections.find do |object|
      object.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @collections.find_all do |object|
     object.name.downcase.include? (name.downcase)
   end
  end

  def delete(id)
    @collections.delete_if do |object|
      object.id == id
    end
  end

  def object_id_counter
    @collections.max do |object|
     object.id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @collections.find_all do |object|
      object.invoice_id == invoice_id
    end
  end

  def find_all_by_result(result)
    @collections.find_all do |object|
      object.result == result
    end
  end

  def find_all_by_item_id(item_id)
    @collections.find_all do |object|
      object.item_id == item_id
    end
  end
  
  def inspect
    "#<#{self.class} #{@collections.size} rows>"
  end
end
