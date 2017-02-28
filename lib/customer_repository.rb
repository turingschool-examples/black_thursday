require_relative 'customer'

class CustomerRepository
  attr_reader :customer_data, :all, :parent

  def initialize(customer_data, parent = nil)
    @customer_data = customer_data
    @all = customer_data.map { |row| Customer.new(row, self)}
    @parent = parent
  end


  def find_by_id(id)
    all.find {|object| object.id == id }
  end

  def find_all_by_first_name(first_name)
    all.find_all {|object| object.first_name.downcase.include?(first_name.downcase) }
  end

  def find_all_by_last_name(last_name)
    all.find_all {|object| object.last_name.downcase.include?(last_name.downcase) }
  end


  def inspect
    @instance.nil? ? nil : "#<#{self.class} #{@instance.size} rows>"
  end

end
