require 'CSV'
require 'pry'
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

  def update(id, attributes)
      if find_by_id(id) != nil
      merchant_to_be_updated = find_by_id(id)
      merchant_to_be_updated.name = attributes
      else
        nil
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


  # def create(merchant_params)
  #   merchant = Merchant.new(merchant_params)
  #   highest_current = merch_id_counter.id
  #   new_highest_current = highest_current += 1
  #   merchant.id = new_highest_current
  #   @collections << merchant
  #    merchant
  # end



  # def populate(filepath)
  #   CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
  #     @merchants << Merchant.new(data)
  #   end
  # end

end
