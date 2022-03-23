module Convertible
  extend ActiveSupport::Concern

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  def integer_to_custom_base(int_val, base = CHARACTERS.count)
    return nil if base < 2 or base > CHARACTERS.count or int_val.nil?

    stack = []
    needle = int_val
    while needle >= base
      stack << needle%base
      needle = needle/base
    end
    stack << needle
    stack.reverse.map { |s| CHARACTERS[s] }.join
  end

end
