require_relative './test_helper'
require './lib/merchant'
require './lib/merchant_repository'
require 'mocha/minitest'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @engine = mock
    @m_repo = MerchantRepository.new("./data/merchants.csv", @engine)
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

      assert_equal turing, @m_repo.find_by_name("Turing School")
      assert_equal target, @m_repo.find_by_name("target")
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

      assert_equal [target], @m_repo.find_all_by_name("target")
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

  def test_delete
    attributes = {id: 2,
      name: "Exciting Store",
      created_at: "01/07/21",
      updated_at: "01/07/21"}
    @m_repo.create(attributes)
    assert_equal 476, @m_repo.all.count

    @m_repo.delete(12337412)
    assert_equal 475, @m_repo.all.count
  end

  def test_update
    @m_repo.update(12337411, "updated store")
    expected = @m_repo.find_by_id(12337411)
    assert_equal "updated store", expected.name
  end

end
