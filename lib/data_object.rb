require 'bigdecimal'

class DataObject
  def initialize(attributes)
    @attributes = attributes
  end

  def self.from_raw_hash(raw_attrs)
    refined_attrs = normalize_attributes(raw_attrs)
    self.new(refined_attrs)
  end

  def self.normalize_attributes(attrs)
    normalizer = {id:          'convert_to_int',
                  merchant_id: 'convert_to_int',
                  customer_id: 'convert_to_int',
                  invoice_id:  'convert_to_int',
                  unit_price:  'convert_to_big_d',
                  created_at:  'convert_to_dates',
                  updated_at:  'convert_to_dates'}

    normal = attrs.map do |key, value|
      if normalizer[key]
        value = self.send(normalizer[key], value)
      end
      value
    end
  end

  def self.convert_to_int(str_num)
    str_num.to_i
  end

  def self.convert_to_big_d(raw_price)
    price = raw_price.to_f / 100
    p BigDecimal.new(price, raw_price.length)
  end

  def self.convert_to_dates(raw_date)
    Time.parse(raw_date)
  end


  # TODO: Make tests for these
  def id
    @attributes[:id]
  end

  def name
    @attributes[:name]
  end
end
