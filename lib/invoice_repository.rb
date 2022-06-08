require_relative 'entry'
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

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    @all.find {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @all.find_all { |invoice| invoice.status == status }
  end

  def create(attributes)
    new_id = (@all.last.id + 1)
    @all << Invoice.new(
      :id => new_id,
      :customer_id => attributes[:customer_id],
      :merchant_id => attributes[:merchant_id],
      :status => attributes[:status],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
      )

  end

  def update(id, attributes)
    invoice = find_by_id(id)
    invoice.status = attributes[:status]
    invoice.updated_at = Time.now
  end

  def delete(id)
    invoice = find_by_id(id)
    @all.delete(invoice)
  end

end
