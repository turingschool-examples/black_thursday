module Inspectable

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end
