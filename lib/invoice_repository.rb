require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new({
        :id => row[:id],
        :customer_id => row[:customer_id],
        :merchant_id => row[:merchant_id],
        :status => row[:status],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        })
    end
  end
  def create(data_hash)
    id = (@all.last.id.to_i + 1)
    @all << Invoice.new({
      :customer_id => id,
      :merchant_id => data_hash[:merchant_id],
      :status => data_hash[:status],
      :created_at => data_hash[:created_at],
      :updated_at => data_hash[:updated_at]
      })
  end
  def update(customer_id, status)
    @all.find_by_id(customer_id).status = status
    @ll.find_by_id(customer_id).updated_at = Time.now
  end
  #refactor delete
    def delete(customer_id)
      array = @all.delete(@all.find_by_id(customer_id))
    end
end
