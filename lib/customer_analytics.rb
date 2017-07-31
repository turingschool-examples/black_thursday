module CustomerAnalytics

  def top_buyers(num=20)
    duplicated_merchant_repo = @merchants.id_repo.clone
    top = []
    number.times do
      max = duplicated_merchant_repo.max_by {|merchant| revenue_by_merchant(merchant[0])}
      duplicated_merchant_repo.delete(max[0])
      top << @merchants.find_by_id(max[0])
    end
    top



end
