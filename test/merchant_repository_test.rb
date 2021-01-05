require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))

    assert_instance_of MerchantRepository, mr
  end

  def test_all #needs to be an array of all merchants
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))

    assert_instance_of CSV::Table, mr.all
    assert_equal 475, mr.all.count

  end

  def test_find_by_invalid_id
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))

    assert_nil mr.find_by_id(000)
  end

  def test_find_by_valid_id
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))
    m = mr.merchants.first

    assert_equal m, mr.find_by_id(12334105)
  end

  def test_find_by_non_existent_name
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))


    assert_nil mr.find_by_name("PaidPiper")
  end

  def test_find_by_name
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))
    m = mr.merchants.first
    m1 = mr.merchants[7]

    assert_equal m, mr.find_by_name("Shopin1901")
    assert_equal m1, mr.find_by_name("jejum")
  end

  def test_find_all_by_name #returns either [] of one or more matches which contain the supplied name fragment, case insensitive.
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))
    m = mr.merchants[15]
    m1 = mr.merchants[45]
    m2 = mr.merchants[119]
    m3 = mr.merchants[143]
    m4 = mr.merchants[172]

    assert_equal [m, m1, m2, m3, m4], mr.find_all_by_name("just")
  end

  def test_max_merchant_id
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))

    assert_equal '12337411', mr.max_merchant_id[:id]
  end

  def test_create_new_merchant #create a new Merchant instance with the provided attributes. The new Merchant’s id should be the current highest Merchant id plus 1.
    skip
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))
    m = mock("randomProductions")

    assert_equal m, mr.create("randomProductions")
  end

  def test_update_with_id_and_attributes
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))
    mr.update(12334105, "Shoping1901")
    m1 = mr.merchants.first

    assert_equal "Shoping1901", m1[:name]
  end

  def test_delete_with_id #delete the Merchant instance with the corresponding id
    skip
    mr = MerchantRepository.new(CSV.readlines("./data/merchants.csv", headers: true, header_converters: :symbol))
    # m1 = mr.merchants.first

    mr.delete(12334105)

    assert_nil mr.find_by_id(12334105)
  end
end
