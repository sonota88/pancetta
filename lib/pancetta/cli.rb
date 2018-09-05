require 'pancetta/model'

module Pancetta
  class Cli
    def self.run(args)
      base_commit = args.shift

      Model.new.run(base_commit)
    end

  end
end
