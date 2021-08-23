module Pancetta
  module Linter
    class Standardrb
      def run
        system "bundle exec standardrb"
      end
    end
  end
end
