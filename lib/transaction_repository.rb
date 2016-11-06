require_relative 'find_functions'
<<<<<<< HEAD
require_relative 'transaction'
require 'csv'

class TransactionRepository
=======
require_relative 'item'
require 'csv'

class ItemRepository
>>>>>>> 078488ee770870ecb65f9d832e5f99845f478834

  include FindFunctions

  attr_reader :file_contents,
              :all,
              :parent

  def initialize(file_name = nil, engine = nil)
    return unless file_name
    @parent        = engine
    @file_contents = load(file_name)
<<<<<<< HEAD
    @all           = create_transaction_objects
=======
    @all           = create_item_objects
>>>>>>> 078488ee770870ecb65f9d832e5f99845f478834
  end

  def inspect
    "#<#{self.class}: #{@all.count} rows>"
  end

  def load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

<<<<<<< HEAD
  def create_transaction_objects
    @file_contents.map { |row| Transaction.new(row, self) }
  end

  def find_invoice_by_id(invoice_id)
    parent.find_invoice_by_id(invoice_id)
=======
  def create_item_objects
    @file_contents.map { |row| Item.new(row, self) }
  end

  def find_merchant_by_id(id)
    parent.find_merchant_by_id(id)
>>>>>>> 078488ee770870ecb65f9d832e5f99845f478834
  end

  def find_by_id(id)
    find_by(:id, id)
  end

<<<<<<< HEAD
  def find_all_by_invoice_id(invoice_id)
    find_all(:invoice_id, invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all(:credit_card_number, credit_card_number)
  end

  def find_all_by_result(result)
    find_all(:result, result)
=======
  def find_by_name(name)
    find_by(:name, name)
  end

  def find_all_with_description(description)
    find_all(:description, description)
  end

  def find_all_by_price(price)
    find_all(:unit_price, price)
  end

  def find_all_by_price_in_range(price_range)
    all.find_all { |item| price_range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    find_all(:merchant_id, merchant_id)
>>>>>>> 078488ee770870ecb65f9d832e5f99845f478834
  end

end
