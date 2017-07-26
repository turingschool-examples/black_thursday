class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = sales_engine.merchants
    @items = sales_engine.items
  end

  def sum_repo(repository)
    sum = 0
    repository.id_repo.each do |merchant|
      sum += 1
    end
  end

  def average_items_per_merchant
    sum_repo(@items) / sum_repo(@merchants)
    #somehow need to round to 2 decimal points
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
