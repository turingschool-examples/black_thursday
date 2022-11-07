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

  def update(id, attributes)
      sanitized_attributes = {
      name: attributes[:name]
    }
    super(id, sanitized_attributes)
  end
end
