require './test/test_helper'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @mr = MerchantRepository.new
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_merchant_repo_has_attribute
    @mr.create({name: "Lil' Caesar's"})
    assert_equal "Lil' Caesar's", @mr.members[0].name
  end

  def test_merch_repo_can_create_new_merchants
    assert_equal [], @mr.members

    @mr.create({name: "Howie Mandell"})

    assert_equal 1, @mr.members.count
    assert_equal "Howie Mandell", @mr.members[0].name
    assert_equal 0, @mr.members[0].id

    @mr.create({name: "Billy Dee Williams"})

    assert_equal 2, @mr.members.count
    assert_equal "Billy Dee Williams", @mr.members[1].name
    assert_equal 1, @mr.members[1].id
  end

  def test_merch_repo_can_return_all_merchants
    @mr.create({name: "Howie Mandell"})
    @mr.create({name: "Billy Dee Williams"})

    assert_equal "Howie Mandell", @mr.all[0].name
    assert_equal 0, @mr.all[0].id
    assert_equal "Billy Dee Williams", @mr.all[1].name
    assert_equal 1, @mr.all[1].id
  end

  def test_merch_repo_can_find_by_id
    @mr.create({name: "Howie Mandell"})

    assert_equal "Howie Mandell", @mr.find_by_id(0).name
  end

  def test_merch_repo_can_find_by_name
    @mr.create({name: "Billy Dee Williams"})

    assert_equal 0, @mr.find_by_name("Billy Dee Williams").id
  end

  def test_merch_repo_can_find_all_by_id
    assert_equal [], @mr.find_all_by_name("Billy")

    @mr.create({name: "Billy Dee Williams"})

    assert_equal 1, @mr.find_all_by_name("Billy").count
    assert_instance_of Merchant, @mr.find_all_by_name("Billy")[0]
  end

  def test_merch_repo_can_delete_merchant
    @mr.create({name: "Billy Dee Williams"})

    @mr.delete(0)

    assert_equal [], @mr.members
  end

  def test_merch_repo_can_update_attributes_of_items
    @mr.create({name: "Billy Dee Williams"})

    @mr.update(0, {name: "Charles deGaulle"})

    assert_equal "Charles deGaulle", @mr.members[0].name
  end
end
