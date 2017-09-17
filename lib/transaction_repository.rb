require_relative 'transaction'
require 'csv'
require 'pry'

class TransactionRepository

  attr_reader :all

  def initialize(file_path, parent = nil)
    @all = from_csv(file_path)
  end

  def from_csv(file_path)
    trxr_array = []
    CSV.foreach(file_path, headers: true, :header_converters => :symbol) do |row|
      trxr_array << Transaction.new(row)
    end
    trxr_array
  end

  def find_by_id(id)
    @all.find do |transaction_item|
      transaction_item.id == id
    end
  end

  def find_all_by_item_id(invoice_id)
    @all.find_all do |transaction_item|
      transaction_item.invoice_id == invoice_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction_item|
      transaction_item.invoice_id == invoice_id
    end
  end

end
