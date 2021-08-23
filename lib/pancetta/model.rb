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
        system "bundle exec standardrb"
      else
        raise "not supported"
      end
    end
  end
end
