module Pancetta
  module Linter
    class Checkstyle
      def run
        conf = YAML.load(File.read("checkstyle.yaml"))
        p conf
        system("java", "-jar", conf["jar_path"], "-c", conf["conf_path"], "src/")
      end

      def target?(path)
        path.end_with?(".java")
      end
    end
  end
end
