require "yaml"

module Pancetta
  class Model
    def run(linter_type)
      linter =
        case linter_type
        when :checkstyle
          require "pancetta/linter/checkstyle"
          Linter::Checkstyle.new
        when :standardrb
          require "pancetta/linter/standardrb"
          Linter::Standardrb.new
        else
          raise "not supported"
        end

      linter.run
    end
  end
end
