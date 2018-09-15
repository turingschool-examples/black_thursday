require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/transaction_repo'

class TransactionRepoTest < Minitest::Test
  def test_it_exist
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")
    assert_instance_of TransactionRepo, tr
  end

  def test_it_returns_all_items_in_an_array
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    assert_equal "0217", tr.all.first.credit_card_expiration_date
    assert_instance_of Array, tr.all
    assert_equal 11, tr.all.count
    assert_equal "success", tr.all.first.result
  end

  def test_it_can_find_an_item_by_id
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    actual = tr.find_by_id(2)
    assert_instance_of Transaction, actual
    assert_equal "success", actual.result
    assert_equal 2, actual.id
  end

  def test_it_returns_nil_if_no_id_match_found
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    actual = tr.find_by_id(28349289034)
    assert_nil actual
  end

  def test_it_can_find_all_invoice_by_id
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    t_one = tr.find_by_id(4)
    t_two = tr.find_by_id(5)

    expected = [t_one, t_two]
    actual = tr.find_all_by_invoice_id(4115)
    assert_equal expected, actual

    assert_equal [], tr.find_all_by_invoice_id(99999)
  end

  def test_it_can_find_all_by_credit_card_number
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    t_one = tr.find_by_id(4)
    t_two = tr.find_by_id(5)

    expected = [t_one, t_two]
    actual = tr.find_all_by_credit_card_number("4048033451067370")
    assert_equal expected, actual

    assert_equal [], tr.find_all_by_credit_card_number(99999)
  end

  def test_it_can_find_all_with_a_description
    skip
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")


    chicken = ir.find_by_id(3)
    student = ir.find_by_id(7)

    expected = [chicken, student]
    actual = ir.find_all_with_description("eat it")
    assert_equal expected, actual

    assert_equal [], ir.find_all_with_description("jifeowjflsjeioa")
  end

  def test_it_can_find_all_by_result
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    expected = tr.find_by_id(9)
    assert_equal [expected], tr.find_all_by_result("failed")

    actual = tr.find_all_by_result("success")
    assert_equal 10, actual.count

    assert_equal [], tr.find_all_by_result("asdfdf")
  end

  # def test_it_can_create_a_transaction_with_current_highest_id
  #   tr = TransactionRepo.new("./test/fixtures/transactions.csv")
  #
  #   actual = tr.create({
  #     :id                            => 15,
  #     :invoice_id                    => 232321,
  #     :credit_card_number            => "4463525332822968",
  #     :credit_card_expiration_date   => "0422",
  #     :result                        => "failed",
  #     :created_at                    => Time.now,
  #     :updated_at                    => Time.now,
  #                       })
  #
  #   assert_instance_of Transaction, actual
  #
  # assert_equal 11, tr.all.count
  # end

  def test_it_finds_update_a_transaction
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    
  end

  def test_it_can_create_a_new_item_with_new_parameters
    skip
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")


    actual  = ir.create({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                        })

    assert_instance_of Item, actual
  end

  def test_the_new_items_id_increments_by_one
    skip
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")


    actual  = ir.create({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
                        })
    assert_equal 8, actual.id
  end

  def test_it_can_update_items_attributes_with_correspending_id
    skip
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    actual = ir.find_by_id(6)
    ir.update(6, {:name => "Dude dog mountain",
                  :description => "Every dating profile in CO ever",
                  :unit_price => BigDecimal.new(10.99,4)})
    assert_equal "Dude dog mountain", actual.name
    assert_equal "Every dating profile in CO ever", actual.description
    assert_equal 10.99, actual.unit_price
    assert_instance_of Time, actual.updated_at
  end

  def test_update_merchant_id_doesnt_work
    skip
      tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    ir.update(6, {:id => 100,
                  :name => "Dude dog mountain",
                  :description => "Every dating profile in CO ever",
                  :unit_price => BigDecimal.new(10.99,4)})

    actual = ir.find_by_name("Dude dog mountain").id

    assert_equal 6, actual
  end

  def test_it_can_delete_the_item_with_corresponding_id
    skip
    tr = TransactionRepo.new("./test/fixtures/transactions.csv")

    ir.delete(1)
    assert_nil ir.find_by_id(1)
  end

end
