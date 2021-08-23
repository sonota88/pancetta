require "yaml"

module Pancetta
  module Cli
    def self.run(args)
      conf = YAML.load(File.read("checkstyle.yaml"))
      p conf
      puts "TODO"
    end
  end
end
