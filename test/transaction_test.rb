require_relative './test_helper'
require 'time'

class TransactionTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"
    transaction_path   = "./data/transactions.csv"

    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers => customer_path,
                  :transactions => transaction_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @transaction = @engine.transactions.find_by_id(1)
    #let(:transaction) { engine.transactions.find_by_id(1) }
  end

    def test_id_returns_the_transaction_id
      assert_equal 1, @transaction.id
      assert_equal Fixnum, @transaction.id.clas
    end

    def test_invoice_id_returns_the_invoice_id
      assert_equal 2179, @transaction.invoice_id
      assert_equal Fixnum, @transaction.invoice_id.class
    end

    def test_credit_card_number_returns_the_credit_card_number
      assert_equal "4068631943231473", @transaction.credit_card_number
      assert_equal Stringexpect, @transaction.credit_card_number.class
    end
  #
  #     it "#credit_card_number returns the credit card number" do
  #       expect(transaction.credit_card_number).to eq "4068631943231473"
  #       expect(transaction.credit_card_number.class).to eq String
  #     end
  #
  #     it "#credit_card_expiration_date returns the credit card expiration" do
  #       expect(transaction.credit_card_expiration_date).to eq "0217"
  #       expect(transaction.credit_card_expiration_date.class).to eq String
  #     end
  #
  #     it "#result returns the result" do
  #       expect(transaction.result).to eq :success
  #       expect(transaction.result.class).to eq Symbol
  #     end
  #
  #     it "#created_at returns a Time instance for the date the invoice item was created" do
  #       expect(transaction.created_at).to eq Time.parse("2012-02-26 20:56:56 UTC")
  #       expect(transaction.created_at.class).to eq Time
  #     end
  #
  #     it "#updated_at returns a Time instance for the date the invoice item was last updated" do
  #       expect(transaction.updated_at).to eq Time.parse("2012-02-26 20:56:56 UTC")
  #       expect(transaction.updated_at.class).to eq Time
  #     end
  #   end
