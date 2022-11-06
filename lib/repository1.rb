class Repository

  def parse_data(file, class_var)
    rows = CSV.open file, headers: true, header_converters: :symbol
    rows.each do |row|
      new_obj = class_var.new(row.to_h)
      # require 'pry'; binding.pry
      @repo << new_obj
    end
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end
end