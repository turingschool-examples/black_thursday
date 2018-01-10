require "./test/test_helper"
require "./lib/calculator"


class CalculatorTest < MiniTest::Test
  include Calculator
 def test_days_returns_proper_values
   assert_equal "Sunday" , DAYS[0]
   assert_equal "Monday", DAYS[1]
   assert_equal "Tuesday", DAYS[2]
   assert_equal "Wednesday", DAYS[3]
   assert_equal "Thursday", DAYS[4]
   assert_equal "Friday", DAYS[5]
   assert_equal "Saturday", DAYS[6]
 end

 def test_months_takes_month_string_returns_month_number_as_string
   assert_equal "01" , MONTHS["january"]
   assert_equal "02", MONTHS["february"]
   assert_equal "03", MONTHS["march"]
   assert_equal "04", MONTHS["april"]
   assert_equal "05", MONTHS["may"]
   assert_equal "06", MONTHS["june"]
   assert_equal "07", MONTHS["july"]
   assert_equal "08", MONTHS["august"]
   assert_equal "09", MONTHS["september"]
   assert_equal "10", MONTHS["october"]
   assert_equal "11", MONTHS["november"]
   assert_equal "12", MONTHS["december"]
 end

 def test_average_rerutns_average_as_a_float
  assert_instance_of Float, average(9, 30)
  assert_equal 0.3, average(9, 30)
 end

 def test_sqrt_exponentiates_by_half_return_square_as_float
   assert_instance_of Float, sqrt(9)

   assert_equal 3, sqrt(9)
 end

 def test_sqrt_works_for_prime_number
   assert_equal 4.123105625617661, sqrt(17)
 end
end
