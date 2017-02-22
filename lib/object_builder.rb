class ObjectBuilder

  def read_csv(args)
    { merchant: build_object(args[:merchant], Merchant)
      }
  end

  def build_object(path, class_type)

  end
end
