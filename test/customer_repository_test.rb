require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/repository'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../test/file_hash_setup'

class CustomerRepositoryTest < Minitest::Test

  attr_reader :file_hash, :path, :se, :repo, :customer_repository

  include FileHashSetup

  def setup
    super
    @path = 'test/fixtures/customer_sample.csv'
    @repo = Repository.new(se, path, Customer)
    @customer_repository = CustomerRepository.new(se, path)
  end

  def test_it_finds_all_customers

  end

end
