require 'csv'
require 'time'
require_relative 'transaction'
require_relative 'helper_methods'

class TransactionRepository
  include HelperMethods
  attr_reader :all, :engine

  def initialize(file_path, engine)
    @file_path = file_path.to_s
    @engine = engine
    @all = Array.new
    create_transactions
  end

  def create_transactions
    data = CSV.parse(File.read(@file_path), headers: true, header_converters: :symbol) do |line|
      @all << Transaction.new(line.to_h, self)
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_all_by_credit_card_number(credit_card_number)
    result = @all.select do |line|
      line.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    result = @all.select do |line|
      line.result.to_sym == result.to_sym
    end
  end

  def create(attributes)
    @all << Transaction.new(
      {
        :id => create_new_id,
        :invoice_id => attributes[:invoice_id],
        :credit_card_number => attributes[:credit_card_number],
        :credit_card_expiration_date => attributes[:credit_card_expiration_date],
        :result => attributes[:result],
        :created_at => attributes[:created_at],
        :updated_at => attributes[:updated_at],
      }, self
    )
  end

  def update(id, attributes)
    result = find_by_id(id)
    unless result == nil
      @all.delete(result)
      result.credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number] != nil
      result.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date] != nil
      result.result = attributes[:result].to_sym if attributes[:result] != nil
      result.updated_at = Time.now
      @all << result
    end
  end

end
