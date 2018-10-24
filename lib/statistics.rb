module Statistics
  def standard_deviation(*nums)
    av = average(*nums)
    diffs = nums.map{|n| n - av}
    Math.sqrt(diffs.map{|n|n**2}.inject(&:+).to_f / 2.to_f)
  end
  def average(*nums)
    nums.inject(&:+) / nums.size.to_f
  end
end
