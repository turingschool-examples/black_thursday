require 'CSV'

class InvoiceRepository

  attr_reader :all


  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new(
        :id => row[:id],
        :customer_id => row[:customer_id].to_i,
        :merchant_id => row[:merchant_id].to_i,
        :status => row[:status],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        )
      end
  end






end
