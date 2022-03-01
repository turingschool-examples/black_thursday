class CustomerRepository
  attr_reader :customers

  def initialize(customers)
    @customers = customers
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find {|merchant| merchant.id == id }
  end

  def find_by_name(name)
    @customers.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(fragment)
    @customers.find_all { |merchant| merchant.name.downcase.include?(fragment)}
  end

  def create(attributes)
    @customers.sort_by { |merchant| merchant.id}
    last_id = @customers.last.id
    attributes[:id] = (last_id += 1)
    @customers << Merchant.new(attributes)
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    attributes.map do |key, v|
      # require "pry"; binding.pry
        merchant.name = v if key == :name
    end
  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
