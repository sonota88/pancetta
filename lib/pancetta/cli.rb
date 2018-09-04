# coding: utf-8

require "pancetta/pancetta"

module Pancetta
  class Cli
    def self.run(args)
      base_commit = args.shift

      Pancetta.new.run(base_commit)
    end

  end
end
