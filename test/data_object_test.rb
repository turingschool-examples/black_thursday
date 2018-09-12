require_relative 'test_helper'
require_relative '../lib/data_object'

class DataObjectTest < Minitest::Test
  def setup
    @object = DataObject.new({})
    @time_1 = '1993-10-28 11:56:40 UTC'
    @time_2 = '1993-09-29 12:45:30 UTC'
    @raw_data = {id:          '123',
                name:        'testname',
                description: 'fakedescription',
                merchant_id: '456',
                customer_id: '789',
                invoice_id:  '1011',
                unit_price:  '1200',
                created_at:  @time_1,
                updated_at:  @time_2}
  end

  def test_it_exists
    assert_instance_of(DataObject, @object)
  end

  def test_it_can_convert_to_time_object
    actual = DataObject.convert_to_dates(@time_1)
    expected = Time.parse(@time_1)
    assert_equal(expected, actual)
  end

  def test_it_can_convert_to_big_decimal
    actual = DataObject.convert_to_big_d("1200")
    expected = BigDecimal(12.00, 4)
    assert_equal(expected, actual)
  end

  def test_it_normalizes_data
    actual = DataObject.normalize_attributes(@raw_data)
    expected = {id:          123,
                name:        'testname',
                description: 'fakedescription',
                merchant_id: 456,
                customer_id: 789,
                invoice_id:  1011,
                unit_price:  BigDecimal.new(12.00, 4),
                created_at:  Time.parse(@time_1),
                updated_at:  Time.parse(@time_2)}
    assert_equal(expected, actual)
  end

  class Dummy < DataObject; end

  def test_subclass_initializes_from_raw_hash_with_normalized_attributes
    dummy = Dummy.from_raw_hash(@raw_data)
    assert_equal(123, dummy.id)
    assert_instance_of(Dummy, dummy)
    assert_equal('testname', dummy.name)
  end
end
