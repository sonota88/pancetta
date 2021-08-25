require "rexml/document"

require "pancetta/issue"
require "pancetta/block"

module Pancetta
  module Linter
    module CheckstyleUtils
      def self.parse(xml)
        doc = REXML::Document.new(xml)

        blocks = []

        doc.elements.each("checkstyle/file") do |file|
          path = file.attributes["name"]

          issues = file.get_elements("error").map do |error|
            to_issue(error)
          end

          blocks << Block.new(path, issues)
        end

        blocks
      end

      def self.to_issue(orig)
        Issue.from_plain(
          "message"  => orig.attributes["message"],
          "rule"     => orig.attributes["source"],
          "line"     => orig.attributes["line"].to_i,
          "column"   => orig.attributes["column"].to_i,
          "severity" => orig.attributes["severity"]
        )
      end
    end
  end
end
