require 'csv'
require_relative '../lib/transaction'
require_relative 'repoable'

class TransactionRepository
  include Repoable
  attr_reader :file_path
  attr_accessor :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new({
        :id => row[:id],
        :invoice_id => row[:invoice_id],
        :credit_card_number => row[:credit_card_number],
        :credit_card_expiration_date => row[:credit_card_expiration_date],
        :result => row[:result],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        })
    end
  end

  def find_all_by_credit_card_number(cc)
    @all.find_all { |transaction| transaction.credit_card_number.to_i == cc}
  end

  def find_all_by_result(result)
    @all.find_all { |transaction| transaction.result == result}
  end

  def create(data_hash)
    id = (@all.last.id.to_i + 1)
    @all << Transaction.new({
      :id => id, :invoice_id => data_hash[:invoice_id],
      :credit_card_number => data_hash[:credit_card_number],
      :credit_card_expiration_date => data_hash[:credit_card_expiration_date], :result => data_hash[:result],
      :created_at => data_hash[:created_at], :updated_at => data_hash[:updated_at]
    })
  end

  def update(id, attribute)
   find_by_id(id).credit_card_number = attribute[:credit_card_number]
   find_by_id(id).credit_card_expiration_date = attribute[:credit_card_expiration_date]
   find_by_id(id).updated_at = Time.now
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
