# frozen_string_literal: true

class GoodSmallTextValidator < GoodTextValidator
  class Validation < Validation
    MIN = 1
    MAX = 255

    def perform
      super
      error :too_short, count: MIN if value.to_s.length < MIN
      error :too_long,  count: MAX if value.to_s.length > MAX
    end
  end
end