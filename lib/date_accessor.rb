class DateAccessor

  def self.months
    { 'January'   =>1,
      'February'  =>2,
      'March'     =>3,
      'April'     =>4,
      'May'       =>5,
      'June'      =>6,
      'July'      =>7,
      'August'    =>8,
      'September' =>9,
      'October'   =>10,
      'November'  =>11,
      'December'  =>12}
  end

  def self.weekdays
    { 0 => "Sunday",
      1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday"}
  end

end