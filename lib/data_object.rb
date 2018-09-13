require_relative './modules/precision_math'
require_relative './modules/data_object_helper'

require 'time'

class DataObject
  extend PrecisionMath

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
                  unit_price:  'convert_to_big_d_dollars',
                  created_at:  'convert_to_dates',
                  updated_at:  'convert_to_dates',
                  status:      'convert_to_symbol'}

    attrs.map do |key, value|
      if normalizer[key]
        value = self.send(normalizer[key], value)
      end
      [key, value]
    end.to_h
  end

  def self.convert_to_int(str_num)
    str_num.to_i
  end

  def self.convert_to_big_d_dollars(raw_price)
    raw_price = raw_price.to_f / 100 if raw_price.class != BigDecimal
    convert_to_big_d(raw_price)
  end

  def self.convert_to_dates(raw_date)
    return raw_date if raw_date.class == Time
    Time.parse(raw_date)
  end

  def self.convert_to_symbol(string)
    string.to_sym
  end

  def update(attributes)
    normal = DataObject.normalize_attributes(attributes)
    normal.each do |key, value|
      if @editable.include?(key)
        @attributes[key] = normal[key]
      end
    end
    @attributes[:updated_at] = Time.now
  end

  def id
    @attributes[:id]
  end

  def name
    @attributes[:name]
  end
end
