module Convertible
  extend ActiveSupport::Concern

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  def integer_to_chars_base(int_val)
    return nil if int_val.nil?

    stack = []
    needle = int_val
    base = CHARACTERS.count
    while needle >= base
      stack << needle/base
      needle = needle%base
    end
    stack << needle
    stack.map { |s| CHARACTERS[s] }.join
  end

end
