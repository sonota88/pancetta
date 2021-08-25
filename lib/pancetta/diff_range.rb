module Pancetta
  class DiffRange
    def initialize(from, len)
      @from = from
      @len = len
    end

    def include?(n)
      @from + 3 <= n && n < @from + @len - 3
    end

    def inspect
      "(#{@from},#{@len})"
    end
  end
end
