module Pancetta
  module Linter
    class Standardrb
      def run(files)
        file_list = files.join(" ")
        `bundle exec standardrb -f json #{file_list}`
      end

      def target?(path)
        path.end_with?(".rb")
      end
    end
  end
end
