module Statistics
  def stand_deviation(*nums)
    nums
  end
  def average(*nums)
    nums.inject(&:+) / nums.size
  end
end
