gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'


class InvoiceClassTest < Minitest::Test

  def setup
