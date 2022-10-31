module Find
  def all
    if @merchants != []
      return @merchants
    else
      return @items
    end
  end
end