require 'csv'
require './lib/invoice'
require './lib/repository_aide'

class InvoiceRepository
  include RepositoryAide
  attr_reader :repository

  def initialize(file)
    @invoices = CSV.read(file, headers: true, header_converters: :symbol)

    @repository = @invoices.map do |invoice|
          Invoice.new({
            :id => invoice[:id],
            :customer_id => invoice[:customer_id],
            :merchant_id => invoice[:merchant_id],
            :status => invoice[:status],
            :created_at => invoice[:created_at],
            :updated_at => invoice[:updated_at]
            })
          end
  end

  # def all
  #   @repository
  # end

  # def find_by_id(id)
  #   @repository.find do |invoice|
  #     invoice.id == id
  #   end
  # end

  def find_all_by_customer_id(id)
    @repository.select do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @repository.select do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @repository.select do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    # new_id = @repository.sort_by {|invoice| invoice.id.to_i}.last
    # new_id = new_id.id.to_i
    # new_id += 1

    Invoice.new({:id => new_id.to_s,
    :customer_id => attributes[:customer_id],
    :merchant_id => attributes[:merchant_id],
    :status => attributes[:status],
    :created_at => Time.now,
    :updated_at => Time.now
    })
  end

  def update(id, attribute)
    invoice = find_by_id(id)
    invoice.status = attribute
    invoice.updated_at = Time.now
  end
  # 
  # def delete(id)
  #   @repository.delete(find_by_id(id))
  # end
end
