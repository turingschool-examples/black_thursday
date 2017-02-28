require_relative 'customer'

class CustomerRepository
  def initialize(path, parent)
    @csv = CSV.open path, headers: true, header_converters: :symbol
    @parent = parent
    make_repository
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def make_repository
    @repository = {}
    @csv.read.each do |customer|
      @repository[customer[:id]] = Customer.new(customer, self)
    end
    return self
  end

  def all
    @repository.map do  |key, value|
      value
    end
  end

  def find_by_id(id)
    if @repository[id.to_s]
      @repository[id.to_s]
    else
      nil
    end
  end

  def find_all_by_first_name(first_name)
    all.find_all do |transaction|
      transaction.first_name.downcase.include? first_name.downcase
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |transaction|
      transaction.last_name.downcase.include? last_name.downcase
    end
  end
end