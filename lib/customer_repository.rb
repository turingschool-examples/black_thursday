require 'pry'
require 'csv'
require_relative 'transaction'
require_relative 'customer'
require_relative 'repositable'


class CustomerRepository
  include Repositable
  attr_reader :all, :file_path

  def initialize(file_path)
    @file_path = file_path
    @all = []

    if @file_path
        CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
        @all << Customer.new({:id => row[:id].to_i, :first_name => row[:first_name], :last_name => row[:last_name], :created_at => row[:created_at], :updated_at => row[:updated_at]})
      end
    end
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |customer|
      customer.first_name == first_name
    end
  end
  #
  # def find_all_by_credit_card_number(num)
  #   matching_cc = []
  #   @all.find_all do |transaction|
  #     if transaction.credit_card_number == num
  #       matching_cc << transaction
  #       return matching_cc
  #     end
  #   end
  # end
  #
  # def find_all_by_result(result)
  #   @all.find_all do |transaction|
  #     transaction.result == result
  #   end
  # end
  #
  # def create(attributes)
  #   new_id = attributes[:id] = @all.last.id + 1
  #   @all << Transaction.new({:id => new_id, :invoice_id => attributes[:invoice_id], :credit_card_number => attributes[:credit_card_number], :credit_card_expiration_date => attributes[:credit_card_expiration_date], :result => attributes[:result], :created_at => attributes[:created_at], :updated_at => attributes[:updated_at]})
  # end
  #
  # def update(id, attributes)
  #   transaction = find_by_id(id)
  #   if attributes[:result] == "success".downcase  || "failed".downcase
  #     # require "pry"; binding.pry
  #     transaction.result = attributes[:result]
  #     transaction.credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number] != nil
  #     transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date] != nil
  #   end
  # end
  #
  def inspect
    "#<#{self.class} #{@customers.all} rows>"
  end
end
