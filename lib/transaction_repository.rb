require_relative 'transaction'
require 'csv'

class TransactionRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def from_csv(file_path)
    CSV.foreach(file_path, headers: true, :header_converters => :symbol) do |row|
      @all << Transaction.new(row)
    end
  end

  # def find_by_id(id)
  #   @all.find do |transaction_item|
  #     transaction_item.id == id
  #   end
  # end

  # def find_all_by_item_id(item_id)
  #   @all.find_all do |transaction_item|
  #     transaction_item.item_id == item_id
  #   end
  # end

  # def find_all_by_invoice_id(invoice_id)
  #   @all.find_all do |transaction_item|
  #     transaction_item.invoice_id == invoice_id
  #   end
  # end

end
