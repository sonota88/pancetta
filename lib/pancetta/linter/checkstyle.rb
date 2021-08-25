require_relative "checkstyle_utils"

module Pancetta
  module Linter
    class Checkstyle
      def run(files)
        conf = YAML.load(File.read("checkstyle.yaml"))
        cmd = [
          "java", "-jar", conf["jar_path"],
          "-c", conf["conf_path"],
          "-f=xml",
          *files
        ].join(" ")
        `#{cmd}`
      end

      def target?(path)
        path.end_with?(".java")
      end

      def parse(raw_output)
        CheckstyleUtils.parse(raw_output)
      end
    end
  end
end
