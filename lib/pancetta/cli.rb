require "yaml"

module Pancetta
  module Cli
    def self.run(args)
      conf = YAML.load(File.read("checkstyle.yaml"))
      p conf
      system("java", "-jar", conf["jar_path"], "-c", conf["conf_path"], "src/")
      puts "TODO"
    end
  end
end
