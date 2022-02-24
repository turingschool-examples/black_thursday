require 'csv'

class Merchant
  attr_reader :created_at
  attr_accessor :name, :updated_at
  def initialize(data)
    @name = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @id = data[:id]
  end

  def id
    @id.to_i
  end

  def self.read_file(csv)
    merchant_rows = CSV.read(csv, headers: true, header_converters: :symbol)
    merchant_rows.map do |row|
      new(row)
    end
  end
end
