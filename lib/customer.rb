require 'csv'

class Customer
  attr_reader :created_at, :id
  attr_accessor :first_name, :last_name, :updated_at
  def initialize(data)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def self.read_file(csv)
    customer_rows = CSV.read(csv, headers: true, header_converters: :symbol)
    customer_rows.map do |row|
      new(row)
    end
  end

end
