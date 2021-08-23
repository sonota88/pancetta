require "yaml"

module Pancetta
  module Cli
    def self.run(args)
      linter_type = args.shift
      case linter_type
      when "checkstyle"
        conf = YAML.load(File.read("checkstyle.yaml"))
        p conf
        system("java", "-jar", conf["jar_path"], "-c", conf["conf_path"], "src/")
      when "standardrb"
        system "bundle exec standardrb"
      else
        raise "not supported"
      end
    end
  end
end
