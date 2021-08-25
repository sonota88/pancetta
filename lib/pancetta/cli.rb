require "pancetta/model"

module Pancetta
  module Cli
    def self.run(args)
      linter_type = args.shift.to_sym
      base_commit = args.shift

      if base_commit.nil?
        raise "base_commit is required"
      end

      Model.new.run(linter_type, base_commit)
    end
  end
end
