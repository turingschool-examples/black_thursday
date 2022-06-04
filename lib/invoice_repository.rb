require 'time'
require 'CSV'
require_relative "merchant"
require_relative "invoice"
require_relative "item"
require_relative '../modules/findable'
require_relative '../modules/deletable'

class InvoiceRepository
  include Findable
  include Deletable

  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new(row)
    end
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

  def create(attributes)
    attributes[:id]= find_max_id + 1
    @all << Invoice.new(attributes)
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    if invoice == nil
      exit
    else
      invoice.status = attributes[:status]
    end
    find_by_id(id).updated_at = Time.now if find_by_id(id).class == Invoice
  end

end
