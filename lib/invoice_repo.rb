require 'CSV'
require_relative './cleaner.rb'
require_relative './invoice.rb'


class InvoiceRepository
  attr_reader :invoices

  def initialize(file = './data/invoices.csv', engine)
    @engine = engine
    @file = file
    @invoices = {}
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
    build_invoices
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  # def build_invoices
  #   @data.each do |invoice|
  #     @invoices << Invoice.new({:id => invoice[:id].to_i,
  #               :customer_id  => invoice[:customer_id],
  #               :merchant_id  => invoice[:merchant_id],
  #               :status => invoice[:status],
  #               :created_at  => Time.now,
  #               :updated_at  => Time.now}, self)
  #   end
  #   @invoices
  # end

  def build_invoices
    @data.each do |invoice|
      cleaner = Cleaner.new
      @invoices[invoice[:id].to_i] = Invoice.new({
                                        :id => cleaner.clean_id(invoice[:id]),
                                        :customer_id  => cleaner.clean_id(invoice[:customer_id]),
                                        :merchant_id  => cleaner.clean_id(invoice[:merchant_id]),
                                        :status => cleaner.clean_status(invoice[:status]),
                                        created_at: cleaner.clean_date(invoice[:created_at]),
                                        updated_at: cleaner.clean_date(invoice[:updated_at])}, self)
      end
  end

  def all
    @invoices.values
  end

  def find_by_id(id)
    @invoices[id]
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id.to_i == customer_id
    end
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |invoice|
      invoice.merchant_id == merch_id
    end
  end

  def find_all_by_status(status)
    stats = []
    all.find_all do |row|
      row.status == status
    end
  end

  # def create(attributes)
  #   new_invoice = Invoice.new({id: (sort_by_id[-1].id + 1),
  #                       customer_id: attributes[:customer_id],
  #                       merchant_id: attributes[:merchant_id],
  #                            status: attributes[:status],
  #                        created_at: attributes[:created_at],
  #                        updated_at: attributes[:updated_at]}, @invoice_repo)
  #   @invoices << new_invoice
  #   new_invoice
  # end

  def sort_by_id
    @invoices.sort_by do |row|
      row.id
    end
  end

  # def update(id, attributes)
  #   invoice = find_by_id(id)
  #   if invoice != nil
  #     attributes.each do |attribute_key, attribute_value|
  #       invoice.update({attribute_key => attribute_value})
  #     end
  #   end
  #   invoice
  # end
  #
  # def updated_at
  #   Time now?
  # end

  def delete(id)
    @invoices.delete(find_by_id(id))
  end
end
