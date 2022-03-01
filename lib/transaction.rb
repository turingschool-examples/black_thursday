require 'pry'
require 'rspec'
require 'csv'
require 'date'
require 'bigdecimal/util'
require_relative 'sales_module'

class Transaction
  include SalesModule
  attr_reader :id, :invoice_id, :created_at
  attr_accessor :credit_card_number, :credit_card_expiration_date, :result, :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def self.read_file(csv)
    rows = CSV.read(csv, headers: true, header_converters: :symbol)
    rows.map do |row|
      new(row)
    end
  end

end
