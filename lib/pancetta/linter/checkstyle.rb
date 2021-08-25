module Pancetta
  module Linter
    class Checkstyle
      def run(files)
        conf = YAML.load(File.read("checkstyle.yaml"))
        p conf
        system(
          "java", "-jar", conf["jar_path"],
          "-c", conf["conf_path"],
          "-f=xml",
          *files
        )
      end

      def target?(path)
        path.end_with?(".java")
      end

      def parse(raw_output)
        raise "TODO"
      end
    end
  end
end
