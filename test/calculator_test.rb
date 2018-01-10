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
end
