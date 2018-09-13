require './test/test_helper'
require './lib/maths.rb'

class MathsTest < Minitest::Test
  include Maths

  def test_it_squares
    assert_equal 0, square(0.to_d)
    assert_equal 25, square(5.to_d)
    assert_equal 121, square(11.to_d)
  end

  def test_it_doubles
    assert_equal 0, double(0.to_d)
    assert_equal 10, double(5.to_d)
    assert_equal 22, double(11.to_d)
  end

  def test_it_calcs_deviation
    skip
    number_1 = 10
    mean_1 = 9

    number_2 = 54321
    mean_2 = 10000

    assert_equal 1, actual_deviation_1
    assert_equal 44321, actual_deviation_2
  end

  def test_it_sums
    skip
    assert_equal 0, [0.to_d, 0.to_d]
    assert_equal 10, [1.to_d, 2.to_d, 3.to_d, 4.to_d]
    assert_equal 100, [10.to_d, 20.to_d, 30.to_d, 40.to_d]
  end
  # def test_it_takes_an_integer_and_mean_and_returns_square_deviation
  #   mean = 5.5
  #   number = 1
  #   expected = 20.25
  #
  #   actual = square_deviation(number, mean)
  #
  #   assert_equal expected, actual
  # end
  #
  # def test_it_takes_array_of_integers_and_returns_numerator_of_variance
  #   numbers = (1..10).to_a
  #   expected = 82.5
  #
  #   actual = variance_numerator(numbers)
  #
  #   assert_equal expected, actual
  # end
  #
  #
  # def test_it_takes_array_of_integers_and_returns_mean
  #   numbers_1 = (1..10).to_a
  #   numbers_2 = [29.99, 9.99, 9.99]
  #   numbers_3 = ACTUAL_AVERAGE_PRICES_PER_MERCHANT
  #
  #   expected_mean_1 = BigDecimal.new("5.50")
  #   expected_mean_2 = BigDecimal.new("16.66")
  #   expected_mean_3 = BigDecimal.new("350.29")
  #
  #   actual_mean_1 = mean(numbers_1)
  #   actual_mean_2 = mean(numbers_2)
  #   actual_mean_3 = mean(numbers_3)
  #
  #   assert_equal expected_mean_1, actual_mean_1
  #   assert_equal expected_mean_2, actual_mean_2
  #   assert_equal expected_mean_3, actual_mean_3
  # end
  #
  # def test_it_takes_total_and_integer_and_returns_percentage
  #   number_1 = 0
  #   number_2 = 5
  #   number_3 = 10
  #
  #   total = 50
  #
  #   actual_percentage_1 = percentage(number_1, total)
  #   actual_percentage_2 = percentage(number_2, total)
  #   actual_percentage_3 = percentage(number_3, total)
  #
  #   assert_equal 0, actual_percentage_1
  #   assert_equal 10, actual_percentage_2
  #   assert_equal 20, actual_percentage_3
  # end
  #
  # def test_it_takes_array_of_integers_and_returns_variance
  #   numbers = (1..10).to_a
  #   expected_variance = BigDecimal.new("9.166666667")
  #
  #   actual_variance = variance(numbers).round(9)
  #
  #   assert_equal expected_variance, actual_variance
  # end
  #
  # def test_it_takes_array_of_integers_and_returns_standard_deviation
  #   numbers_1 = (1..10).to_a
  #   numbers_2 = ACTUAL_ITEM_COUNT_PER_MERCHANT
  #   expected_standard_deviation_1 = 3.03
  #   expected_standard_deviation_2 = 3.26
  #
  #   actual_standard_deviation_1 = standard_deviation(numbers_1)
  #   actual_standard_deviation_2 = standard_deviation(numbers_2)
  #
  #   assert_equal expected_standard_deviation_1, actual_standard_deviation_1
  #   assert_equal expected_standard_deviation_2, actual_standard_deviation_2
  # end
  #
  # def test_it_can_find_top_outliers
  #   numbers_1 = [81, 2, 13, 71, 78, 80, 12, 36]
  #   numbers_2 = ACTUAL_ITEM_COUNT_PER_MERCHANT
  #
  #   mean_1 = mean(numbers_1)
  #   mean_2 = mean(numbers_2)
  #
  #   std_dev_1 = standard_deviation(numbers_1)
  #   std_dev_2 = standard_deviation(numbers_2)
  #
  #   test_case = numbers_2.find_all do |number|
  #     outlier?(number, mean_2, std_dev_2, 1)
  #   end
  #
  #   assert_equal true, outlier?(82, mean_1, std_dev_1, 1)
  #   assert_equal true, outlier?(116, mean_1, std_dev_1, 2)
  #   assert_equal true, outlier?(150, mean_1, std_dev_1, 3)
  #
  #   assert_equal false, outlier?(82, mean_1, std_dev_1, 2)
  #   assert_equal false, outlier?(116, mean_1, std_dev_1, 3)
  #   assert_equal false, outlier?(150, mean_1, std_dev_1, 4)
  #
  #   assert_equal 52, test_case.length
  # end
end
