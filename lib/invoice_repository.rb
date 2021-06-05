require 'csv'
require 'bigdecimal'
require 'time'
require_relative 'invoice'
require_relative 'helper_methods'

class InvoiceRepository
  include HelperMethods
  attr_reader :all, :engine

  def initialize(file_path, engine)
    @file_path = file_path.to_s
    @engine = engine
    @all = Array.new
    create_invoices
  end

  def create_invoices
    data = CSV.parse(File.read(@file_path), headers: true, header_converters: :symbol) do |line|
      @all << Invoice.new(line.to_h, self)
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_by_customer_id(customer_id)
    result = @all.select do |line|
      line.customer_id.to_s == customer_id.to_s
    end
  end

  def find_all_by_merchant_id(merchant_id)
    result = @all.select do |line|
      line.merchant_id.to_i == merchant_id.to_i
    end
  end

  def find_all_by_status(status)
    result = @all.select do |line|
      line.status == status
    end
  end

  def create(attributes)
    @all << Invoice.new(
      {
        :id => create_new_id,
        :customer_id => attributes[:customer_id],
        :merchant_id => attributes[:merchant_id],
        :status => attributes[:status],
        :created_at => attributes[:created_at],
        :updated_at => attributes[:updated_at],
      }, self
    )
  end

  def update(id, attributes)
    result = find_by_id(id)
    unless result == nil
      @all.delete(result)
      result.customer_id = attributes[:customer_id] if attributes[:customer_id] != nil
      result.merchant_id = attributes[:merchant_id] if attributes[:merchant_id] != nil
      result.status = attributes[:status] if attributes[:status] != nil
      #may require modification (doesn't currently align with #Invoice.initialize)
      result.created_at = Time.now
      result.updated_at = Time.now
      @all << result
    end
  end

end
