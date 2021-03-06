module CharshiftHelper

  def self.confirm_fixnum input_val
    if !input_val.instance_of? Fixnum
      raise TypeError, 'Input value must be of type fixnum'
    else
      return true
    end
  end

  def self.encoding_ind_split input_string
    split_string = []

    input_string.each_char do |chr|
      split_string << chr
    end
    return split_string
  end

  def self.get_shift_distance_minus_loops input_val, collection_length
    absloute_input_val = input_val.abs
    remaining_difference = absloute_input_val % collection_length
    if absloute_input_val > collection_length
      return input_val > 0 ? remaining_difference : 0 - remaining_difference
    else
      return input_val
    end
  end

  def self.get_shift_position starting_pos, shift_val, encoding_length
    collection_length = encoding_length
    shift_difference = self.get_shift_distance_minus_loops(shift_val, collection_length)
    start_plus_shift = starting_pos + shift_difference
    if shift_difference + starting_pos == encoding_length
      return 0
    elsif start_plus_shift > collection_length
      return 0 + start_plus_shift - collection_length
    elsif start_plus_shift < 0
      return collection_length + start_plus_shift
    else
      return start_plus_shift
    end
  end

  def self.get_char_by_ord ordinal_value, char_encoding_type
    return ordinal_value.chr(char_encoding_type)
  end

  def self.get_ord_by_char character
    return character.ord
  end

  def self.get_encoding string
    return string.encoding.to_s
  end

  def self.get_encoding_length encoding
    max = 100000000000
    min = 0
    guess = 50000000000

    while true
      begin guess.chr(encoding)
        if (min > max)
          return max + 1
        else
          min = guess + 1
          guess = (max + min) / 2
        end
      rescue
        if min > max
          return max + 1
        else
          max = guess - 1
          guess = (max + min) / 2
        end
      end
    end
  end

  def self.check_for_valid_array_elements string_array
    string_array.each do |chr|
      if !chr.is_a?(String) || chr.length != 1
        return false
      end
    end
    return true
  end

  def self.check_for_uniqueness string_array
    return string_array.uniq.length == string_array.length
  end
end