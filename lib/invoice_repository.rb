require 'CSV'

class InvoiceRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
      CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
        @all << Invoice.new(id: row[:id], merchant_id: row[:merchant_id], status: row[:status], created_at: row[:created_at], updated_at: row[:updated_at])
      end
    end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  # def find_all_by_customer_id(customer_id)
  #   @all.find do |invoice|
  #     # require "pry"; binding.pry
  #     invoice.id + 1 == customer_id
  #   end
  # end

  # def find_all_by_customer_id(customer_id)
  #   @all.find_all { |invoice| require "pry"; binding.pry invoice.customer_id == customer_id}
  #
  # end

  def find_all_by_merchant_id(merchant_id)
    merchant_id_array = []
    @all.find do |invoice|
      # require "pry"; binding.pry
      if invoice.merchant_id == merchant_id
        merchant_id_array << invoice.id
      end
    end
    merchant_id_array
  end

  def find_all_by_status(status)
    status_array = []
    @all.find_all do |invoice|
      # require "pry"; binding.pry
      if invoice.status == status
        status_array << invoice.id
      end
    end
    status_array
  end

end
