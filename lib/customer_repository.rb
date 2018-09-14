require_relative './customer'
require_relative './repository'

class CustomerRepository < Repository

  def initialize(filepath)
    super()
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |datum|
      @data << Customer.new(datum)
    end
  end

end
