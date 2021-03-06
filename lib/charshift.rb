require 'charshifthelper'

class String
  def charshift char_shift_val, custom_encoding = nil
    begin
      CharshiftHelper.confirm_fixnum(char_shift_val)
    rescue TypeError => e
      raise
    else
      output = ""
      split_string = CharshiftHelper.encoding_ind_split(self)
      if custom_encoding
        if CharshiftHelper.check_for_valid_array_elements(custom_encoding) == false
          raise ArgumentError, "Custom encoding must only contain single character string elements"
        elsif CharshiftHelper.check_for_uniqueness(custom_encoding) == false
          raise ArgumentError, "All elements in custom encoding must be unique"
        else
          split_string.each_with_index do |char, index|
            encoding_length = custom_encoding.length
            current_char_ord = custom_encoding.index(char)
            if current_char_ord.nil?
              raise RuntimeError, "Given custom encoding does not contain all characters in the target string"
            end
            shifted_position = CharshiftHelper.get_shift_position(current_char_ord, char_shift_val, encoding_length)
            output << custom_encoding[shifted_position]
          end
        end
      else
        split_string.each do |char|
          char_encoding_type = CharshiftHelper.get_encoding(char)
          encoding_length = CharshiftHelper.get_encoding_length(char_encoding_type) - 1
          current_char_ord = CharshiftHelper.get_ord_by_char(char)
          shifted_position = CharshiftHelper.get_shift_position(current_char_ord, char_shift_val, encoding_length)
          output << CharshiftHelper.get_char_by_ord(shifted_position, char_encoding_type)
        end
      end
      return output
    end
  end

  def charshift! char_shift_val, custom_encoding = nil
    updated_string = charshift char_shift_val, custom_encoding = nil
    return self.replace(updated_string)
  end

  def get_encoding_length
    return CharshiftHelper.get_encoding_length(self.encoding)
  end
end