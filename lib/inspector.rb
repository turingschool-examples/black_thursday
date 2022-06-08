module Inspector

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
