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

  def find_all_by_first_name(name)
    @data.find_all do |datum|
      datum.first_name == name
    end
  end

  def find_all_by_last_name(name)
    @data.find_all do |datum|
      datum.last_name == name
    end
  end
end
