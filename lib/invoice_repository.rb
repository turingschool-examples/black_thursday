require_relative '../lib/invoice'
require_relative '../lib/data_access'

class InvoiceRepository
  include DataAccess
  attr_reader :csv_file,
              :all,
              :parent

  def initialize(path, parent=nil)
    @csv_file = CSV.open(path, headers: true, header_converters: :symbol)
    @all = []
    @parent = parent
    populate_repo
  end

  def populate_repo
    csv_file.each do |row|
      invoice = Invoice.new({:id => row[:id].to_i,
        :customer_id => row[:customer_id].to_i,
        :merchant_id => row[:merchant_id].to_i,
        :status => row[:status].to_sym,
        :created_at => Time.parse(row[:created_at]),
        :updated_at => Time.parse(row[:updated_at])}, self)
        @all << invoice
      end
  end

  def find_all_by_customer_id(customer_id)
    all.select{ |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_status(status)
    all.select{ |invoice| invoice.status == status }
  end
end
