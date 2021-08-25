module Pancetta
  module Linter
    class Standardrb
      def run
        system "bundle exec standardrb"
      end

      def target?(path)
        path.end_with?(".rb")
      end
    end
  end
end
