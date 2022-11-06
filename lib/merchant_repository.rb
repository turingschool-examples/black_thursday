# frozen_string_literal: true
require_relative 'repository'

class MerchantRepository < Repository

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def max_id
    max = @all.max_by(&:id)
    return 1 if max.nil?

    (max.id + 1)
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?

    name = attributes[:name]
    find_by_id(id).name = name
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
