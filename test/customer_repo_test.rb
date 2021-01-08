require 'CSV'
require './test/test_helper'

class CustomerRepoTest < Minitest::Test

  def setup
    @engine = mock
    @dummy_repo = CustomerRepo.new("./dummy_data/dummy_customer.csv", @engine)
  end

  def test_it_is
    assert_instance_of CustomerRepo, @dummy_repo
  end

  def test_it_has_attributes
    assert_instance_of Hash , @dummy_repo.collections
  end

  def test_find_by_id
    actual = @dummy_repo.find_by_id(1)
    assert_equal "Joey", actual.first_name
  end

  def test_find_all_by_first_name
    actual = @dummy_repo.find_all_by_first_name("Joey")
    assert_equal "Nigel", actual[1].last_name
  end

  def test_find_all_by_last_name
    actual = @dummy_repo.find_all_by_last_name("Nader")
    assert_equal "Sebastian", actual[1].first_name
  end

  def test_it_can_create_new_item
    data = {
      :id => 13,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
        }
    @dummy_repo.create(data)
    actual = @dummy_repo.find_by_id(13)
    assert_equal "Joan", actual.first_name
  end

  def test_update
    actual = @dummy_repo.find_by_id(9)
    assert_equal "Dejon", actual.first_name

    @dummy_repo.update({id: 9,
                      first_name: "Khoa",
                      last_name: "Nguyen",
                      })

    actual = @dummy_repo.find_by_id(9)
    assert_equal "Nguyen", actual.last_name
  end

  def test_delete
    data = {
      :id => 13,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
        }
    @dummy_repo.create(data)
    actual = @dummy_repo.find_by_id(13)
    assert_equal "Joan", actual.first_name
    @dummy_repo.delete(13)

    assert_nil nil, @dummy_repo.find_by_id(13)
  end

end
