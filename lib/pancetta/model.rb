require "yaml"

module Pancetta
  class Model
    def run(linter_type)
      case linter_type
      when :checkstyle
        require "pancetta/linter/checkstyle"
        linter = Linter::Checkstyle.new
        linter.run
      when :standardrb
        require "pancetta/linter/standardrb"
        linter = Linter::Standardrb.new
        linter.run
      else
        raise "not supported"
      end
    end
  end
end
