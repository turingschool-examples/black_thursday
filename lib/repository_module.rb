require 'csv'
require 'bigdecimal'
require 'time'


module RepoMethods

  def add_individual_item(object)
    @all << object
  end

  def all
    @all
  end

  def find_by_id(id)
    @all.find do |object|
      object.id == id

    end
  end

  def find_by_name(name)
    @all.find do |object|
      object_name = object.name.downcase
      object_name.include?(name.downcase)
    end
  end

  def update(id, attributes)
    return nil if attributes == {}
    object = find_by_id(id)
    if attributes[:name] != nil
      object.name = attributes[:name]
    end
    if defined? object.description != nil
      if attributes[:description] != nil
        object.description = attributes[:description]
      end
    end
    if defined? object.first_name != nil
      if attributes[:first_name] != nil
        object.first_name = attributes[:first_name]
      end
    end
    if defined? object.last_name != nil
      if attributes[:last_name] != nil
        object.last_name = attributes[:last_name]
      end
    end
    if defined? object.unit_price != nil
      if attributes[:unit_price] != nil
        object.unit_price = attributes[:unit_price]
      end
    end
    if defined? object.quantity != nil
      if attributes[:quantity] != nil
        object.quantity = attributes[:quantity]
      end
    end
    if defined? object.credit_card_number != nil
      if attributes[:credit_card_number] != nil
        object.credit_card_number = attributes[:credit_card_number]
      end
    end
    if defined? object.credit_card_expiration_date != nil
      if attributes[:credit_card_expiration_date] != nil
        object.credit_card_expiration_date = attributes[:credit_card_expiration_date]
      end
    end
    if defined? object.result != nil
      if attributes[:result] != nil
        object.result = attributes[:result]
      end
    end
    if defined? object.updated_at != nil
      object.updated_at = Time.now
    end
  end

  def delete(id)
    object = find_by_id(id)
    @all.delete(object)
  end

end
