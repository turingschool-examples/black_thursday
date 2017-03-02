require_relative "customer"
require_relative "data_access"

class CustomerRepository
  attr_reader :all
  include DataAccess

  def initialize(parent)
    @all = []
    @parent = parent
  end

  def from_csv(path)
    file = CSV.open(path, headers: true, header_converters: :symbol)
    populate_repo(file)
  end

  def populate_repo(file)
  file.each do |row|
    customer = Customer.new({:id => row[:id].to_i,
      :first_name => row[:first_name],
      :last_name => row[:last_name],
      :created_at => Time.parse(row[:created_at]),
      :updated_at => Time.parse(row[:updated_at])}, self)
      @all << customer
    end
  end

  def find_all_by_first_name(first_name)
    name = first_name.downcase
    all.select{|customer| customer.first_name.downcase.include?(name)}
  end

  def find_all_by_last_name(last_name)
    name = last_name.downcase
    all.select{|customer| customer.last_name.downcase.include?(name)}
  end
end