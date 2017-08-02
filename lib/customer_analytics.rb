require 'pry'

module CustomerAnalytics

  def top_buyers(num=20)
    @customers.customers_by_expenditure[0..(num -1)]
  end

end
