# -*- coding: utf-8 -*-
module Furigana
  module Formatter
    class Base
      class << self
        def format(text, tokens)
          element, yomi = 0, 1
          new_text = ''
          tokens_enum = tokens.to_enum
          current_token = tokens_enum.next
          substring, pos = "", 0

          text.each_char do |char|
            if current_token
              substring += char
              if char == current_token[element][pos]
                if pos == current_token[element].length-1
                  new_text += replacement(current_token[element], current_token[yomi])
                  begin
                    current_token = tokens_enum.next
                  rescue StopIteration
                    current_token = nil
                  end
                  substring, pos = "", 0
                else
                  pos += 1
                end
              else # not a match
                new_text += substring
                substring, pos = "", 0
              end
            else # no more tokens
              new_text += char
            end
          end
          new_text
        end
      end
    end
  end
end
