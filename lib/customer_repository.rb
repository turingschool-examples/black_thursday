require_relative 'customer'
require 'csv'

class CustomerRepository
  attr_reader :all, :engine
  def initialize(file_input = nil, engine ="")
    @all = []
    @engine = engine
    from_csv(file_input) if !file_input.nil?
  end

  def from_csv(info)
    CSV.foreach(info, headers: true, header_converters: :symbol) do |row|
      all << Customer.new({id: row[:id], first_name: row[:first_name], last_name: row[:last_name], created_at: row[:created_at], updated_at: row[:updated_at]}, self)
    end
  end

  def find_by_id(id_num)
    all.find {|customer| customer.id == id_num}
  end

  def find_all_by_first_name(first_frag)
    all.select {|customer| customer.first_name.downcase.include?(first_frag.downcase)}
  end

  def find_all_by_last_name(last_frag)
    all.select {|customer| customer.last_name.downcase.include?(last_frag.downcase)}
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

end
