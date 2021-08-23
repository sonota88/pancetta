require "pancetta/model"

module Pancetta
  module Cli
    def self.run(args)
      linter_type = args.shift.to_sym
      Model.new.run(linter_type)
    end
  end
end
