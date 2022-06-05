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

  def find_all_by_status(condition)
    @all.find_all {|row| row.status == condition}
  end

  def add_new(new_id, attributes)
    i = Invoice.new({
                    id: new_id,
                    customer_id: attributes[:customer_id],
                    merchant_id: attributes[:merchant_id],
                    status: attributes[:status],
                    created_at: Time.now,
                    updated_at: Time.now
                    })
    @all.append(i)
    i
  end

  def change(id, key, value)
    if key == :status
      find_by_id(id).status = value.to_sym
      find_by_id(id).updated_at = Time.now
    else
      return nil
    end
  end
end
