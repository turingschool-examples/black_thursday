class Merchant
  attr_reader :id, :name, :parent
  def initialize(hash, parent = nil)
    @id   = hash[:id].to_i
    @name = hash[:name]
    @parent = parent
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
end
