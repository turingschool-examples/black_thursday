require 'csv'
require 'time'
require 'pry'
require_relative '../lib/invoice'
require_relative 'repoable'

class InvoiceRepository
  include Repoable
  attr_reader :file_path
  attr_accessor :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new({
        :id => row[:id],
        :customer_id => row[:customer_id],
        :merchant_id => row[:merchant_id],
        :status => row[:status],
        :created_at => Time.parse(row[:created_at]),
        :updated_at => Time.parse(row[:updated_at])
        })
    end
  end
  def find_all_by_customer_id(cust_id)
    @all.find_all {|invoice| invoice.customer_id.to_i == cust_id}
  end

  def find_all_by_status(status)
    @all.find_all {|invoice| invoice.status == status}
  end

  def create(data_hash)
    id = (@all.last.id.to_i + 1)
    @all <<  Invoice.new({
      :id => id,
      :customer_id => data_hash[:customer_id],
      :merchant_id => data_hash[:merchant_id],
      :status => data_hash[:status],
      :created_at => Time.now,
      :updated_at => Time.now
      })
  end

  def update(id, status)
    find_by_id(id).status = status[:status]
    find_by_id(id).updated_at = Time.now
  end
end
