module Helper

  def self.confirm_int input_val
    if !input_val.instance_of? Fixnum
      raise TypeError, 'Input value must be of type integer'
    else
      return true
    end
  end

  def self.get_abs_shift_diff input_val, collection_length
    abs_input_val = input_val.abs
    if abs_input_val > collection_length
      return abs_input_val % collection_length
    else
      return abs_input_val
    end
  end

  def self.get_shift_position starting_pos, shift_val
    collection_length = 128
    start_plus_shift = starting_pos + shift_val
    if start_plus_shift > collection_length
      return 0 + start_plus_shift - collection_length
    elsif start_plus_shift < 0
      return collection_length + start_plus_shift
    else
      return start_plus_shift
    end
  end

  def self.get_char_by_ord ordinal_value
    return ordinal_value.chr
  end

  def self.get_ord_by_char character
    return character.ord
  end
end