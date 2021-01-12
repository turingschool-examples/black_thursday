require './test/test_helper'
require './lib/merchant_repo'

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @engine = "engine"
  end

  def test_it_exists_with_attributes
    mr = MerchantRepository.new(@engine)

    assert_instance_of MerchantRepository, mr
    assert_equal "engine", mr.engine
  end

  def test_it_can_build_merchants
    mr = MerchantRepository.new(@engine)
    expect = "Shopin1901"

    assert_equal expect, mr.all[0].name
  end

  def test_all
    mr = MerchantRepository.new(@engine)

    assert_equal mr.merchants.count, mr.all.count
  end


  def test_find_by_id
    mr = MerchantRepository.new(@engine)
    merchant1 = mr.find_by_id(12334207)
    merchant0 = mr.find_by_id(1)

    assert_equal 12334207, merchant1.id
    assert_nil merchant0
  end

  def test_find_by_name
    mr = MerchantRepository.new(@engine)
    merchant1 = mr.find_by_name("Shopin1901")
    merchant2 = mr.find_by_name("NERDGEEKs")
    name = "leabUrrot"
    name2 = "Alexa"

    assert_equal 12334411, mr.find_by_name(name).id
    assert_equal "leaburrot", mr.find_by_name(name).name
    assert_equal "Shopin1901", merchant1.name
    assert_equal "NERDGEEKs", merchant2.name
    assert_nil mr.find_by_name(name2)
  end
#
  def test_find_all_by_name
    mr = MerchantRepository.new(@engine)
    name1 = mr.find_all_by_name("style")
    merchant2 = mr.find_by_name("NERDGEEKs")
    name = "g School of Software and Design"
    expected = mr.find_all_by_name(name)

    assert_equal [], expected
    assert_equal 3, name1.length
  end
#
  def test_create_merchant
    mr = MerchantRepository.new(@engine)
    merchant1 = mr.create({:name => "codecodecode"})

    assert_equal "codecodecode", merchant1.name
    assert_equal 12337412, merchant1.id
    assert_equal 476, mr.merchants.count
    assert_equal true, mr.all.include?(merchant1)
  end
#
  def test_update_merchant
    mr = MerchantRepository.new(@engine)
    attributes = {:name => "Brainpeeps"}
    merchant1 = mr.create({:name => "codecodecode"})
    mr.update(merchant1.id, attributes)
    mr.update(12334123, attributes)

    assert_equal "Brainpeeps", merchant1.name
    assert_equal 12337412, merchant1.id
    assert_equal 476, mr.merchants.count
    assert_equal true, mr.all.include?(merchant1)
    assert_equal "Brainpeeps", mr.update(merchant1.id, attributes).name
  end

#   def test_delete_merchant
#     mr = MerchantRepository.new(@engine)
#     merchant1 = mr.create({:name => "codecodecode"})
#     mr.delete(merchant1.id)
#     mr.delete(12334123)
#
#     assert_nil mr.find_by_id(12337412)
#     assert_nil mr.find_by_id(12334123)
#   end
end
