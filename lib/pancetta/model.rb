require "yaml"

module Pancetta
  class Model
    def run(linter_type)
      case linter_type
      when :checkstyle
        conf = YAML.load(File.read("checkstyle.yaml"))
        p conf
        system("java", "-jar", conf["jar_path"], "-c", conf["conf_path"], "src/")
      when :standardrb
        system "bundle exec standardrb"
      else
        raise "not supported"
      end
    end
  end
end
