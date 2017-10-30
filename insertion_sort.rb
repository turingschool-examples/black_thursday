class InsertionSort
  attr_reader :to_sort, :sorted, :to_insert

  def initialize
    @sorted = []
    @to_insert = nil
  end

  def sort(to_sort)
    (to_sort.count).times do
      @to_insert = to_sort.shift
      sorted << to_insert if sorted.count == 0
      find_insert_location
    end
    sorted
  end

  def find_insert_location
    (sorted.count).times do |time|
      break sorted.insert(time, to_insert) if insert_is_less_than(time)
      sorted.insert(time+1, to_insert) if insert_is_greater_than_and_last(time)
    end
  end

  def insert_is_less_than(time)
    sorted[time] > to_insert
  end

  def insert_is_greater_than_and_last(time)
    sorted[time] < to_insert && sorted[time+1].nil?
  end

end
