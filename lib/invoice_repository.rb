require_relative './enumerable'

class InvoiceRepository
  include Enumerable
  attr_reader :all, :file_path

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new({
        :id          => row[:id],
        :customer_id => row[:customer_id],
        :merchant_id => row[:merchant_id],
        :status      => row[:status],
        :created_at  => Time.now,
        :updated_at  => Time.now
        })
    end
  end

  def find_all_by_customer_id(cust_id)
    @all.find_all {|row| row.customer_id == cust_id}
  end

end
