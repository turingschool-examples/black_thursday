require_relative './invoice'
require_relative './repo_methods'
require 'pry'
class InvoiceRepository
  include RepoMethods
  attr_reader :objects_array

  def initialize(file_path)
    @objects_array = invoice_csv_converter(file_path)
  end

  def invoice_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:merchant_id] = obj[:merchant_id].to_i
      obj[:status] = obj[:status].to_sym
      obj[:customer_id] = obj[:customer_id].to_i
      obj[:updated_at] = Time.parse(obj[:updated_at])
      obj[:created_at] = Time.parse(obj[:created_at])
      Invoice.new(obj.to_h)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    findings = @objects_array.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_customer_id(customer_id)
    @objects_array.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_status(status)
    findings = @objects_array.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    max_id = generate_id
    time = attributes[:created_at].getutc
    attributes = {:id => max_id,
                  :merchant_id => attributes[:merchant_id],
                  :status => attributes[:status].to_sym,
                  :customer_id => attributes[:customer_id].to_i,
                  :created_at => time,
                  :updated_at => time }
    @objects_array << Invoice.new(attributes)
  end

  def update(id, attribute)
    invoice = find_by_id(id)
    if attribute[:status].class == Symbol
      invoice.updated_at = Time.now
      invoice.status = attribute[:status]
    else
      'You can not modify this attribute'
    end
  end
end
