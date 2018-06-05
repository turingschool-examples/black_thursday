module MathMethods
  def average(dividend, number)
    (dividend.to_f / number.to_f).round(2)
  end

  def median(array, already_sorted=false)
	  return nil if array.empty?
	  array = array.sort unless already_sorted
	  m_pos = array.size / 2
	  return array.size % 2 == 1 ? array[m_pos] : mean(array[m_pos-1..m_pos])
	end

  # def subtrack_mean(list)
  #   list.length
  #   list.map do |number|
  #     number -
  # end
end
