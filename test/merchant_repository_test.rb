require_relative './test_helper'
require 'time'
require './lib/merchant'
require './lib/merchant_repository'
require 'mocha/minitest'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @engine = mock
    @m_repo = MerchantRepository.new("./fixture_data/merchants.csv", @engine)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of MerchantRepository, @m_repo
    assert_equal false, @m_repo.all.nil?
    assert_equal @m_repo.engine, @engine
  end


  def test_find_by_id
    turing = Merchant.new({id: 1,
                          name: "Turing School",
                          created_at: "01/07/21",
                          updated_at: "01/07/21"}, @engine)

    target = Merchant.new({id: 2,
                          name: "target",
                          created_at: "01/07/21",
                          updated_at: "01/07/21"}, @engine)
    @m_repo.all << turing
    @m_repo.all << target

    assert_equal turing, @m_repo.find_by_id(1)
    assert_equal target, @m_repo.find_by_id(2)
    assert_nil @m_repo.find_by_id(154151554)
  end

  def test_find_by_name
    turing = Merchant.new({id: 1,
      name: "Turing School",
      created_at: "01/07/21",
      updated_at: "01/07/21"}, @engine)

    target = Merchant.new({id: 2,
      name: "target",
      created_at: "01/07/21",
      updated_at: "01/07/21"}, @engine)
      @m_repo.all << turing
      @m_repo.all << target

      assert_equal turing, @m_repo.find_by_name("TurInG School")
      assert_equal target, @m_repo.find_by_name("targeT")
      assert_nil @m_repo.find_by_name("548947asdoihogihof")
  end

  def test_find_all_by_name
    turing = Merchant.new({id: 1,
      name: "Turing School",
      created_at: "01/07/21",
      updated_at: "01/07/21"}, @engine)

    target = Merchant.new({id: 2,
      name: "target",
      created_at: "01/07/21",
      updated_at: "01/07/21"}, @engine)
      @m_repo.all << turing
      @m_repo.all << target

      assert_equal [target], @m_repo.find_all_by_name("arget")
      assert_equal [], @m_repo.find_all_by_name("targetTuring")
  end

  def test_new_highest_id
    start = 12337411
    expected = (start + 1)

    assert_equal expected, @m_repo.new_highest_id
  end

  def test_create
    attributes = {id: 2,
      name: "Exciting Store",
      created_at: "01/07/21",
      updated_at: "01/07/21"}
    @m_repo.create(attributes)
    expected = @m_repo.find_all_by_name("Exciting Store")

    assert_equal expected[0].id, @m_repo.all.last.id
  end

  def test_update
    @m_repo.update(12334141, "updated store")
    expected = @m_repo.find_by_id(12334141)
    merchant_test_updated_at = @m_repo.find_by_id(12334141).updated_at.strftime("%d/%m/%Y")

    assert_equal "updated store", expected.name
    assert_equal Time.now.strftime("%d/%m/%Y"), merchant_test_updated_at
  end

  def test_delete
    assert_equal 475, @m_repo.all.count

    @m_repo.delete(12334141)
    assert_equal 474, @m_repo.all.count
    assert_nil @m_repo.find_by_id(12334141)
  end
end
