require 'time'
# This is the merchant class
class Merchant
  attr_reader :id, :name, :parent, :created_at
  def initialize(hash, parent = nil)
    @id         = hash[:id].to_i
    @name       = hash[:name]
    @created_at = Time.parse(hash[:created_at])
    @parent     = parent
  end

  def items
    payload = ['merchant items', id]
    current_location = self
    while current_location.respond_to?('parent')
      current_location = current_location.parent
    end
    current_location.route(payload)
  end

  def invoices
    payload = ['merchant invoices', id]
    current_location = self
    while current_location.respond_to?('parent')
      current_location = current_location.parent
    end
    current_location.route(payload)
  end

  def customers
    payload = ['merchant customers', id]
    current_location = self
    while current_location.respond_to?('parent')
      current_location = current_location.parent
    end
    current_location.route(payload)
  end
end
