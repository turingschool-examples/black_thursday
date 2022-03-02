require 'pry'
require 'csv'
require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  attr_reader :transactions

  def initialize(data)
    @transactions=[]
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
      @transactions << Transaction.new(row)
    end
    super(@transactions)
  end

  def create(attributes)
    attributes[:id] = @transactions.last.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new_item = Transaction.new(attributes)
    @transactions << new_item
    new_item
  end

  def update(id, attributes)
    item_to_update = find_by_id(id)
    if item_to_update != nil
        attributes.each do |key, value|
          if ![:id, :invoice_id, :created_at].include?(key)
            item_to_update.last_name = value
            item_to_update.updated_at = (Time.now + 1)
          end
        end
    end
    item_to_update
  end
end
