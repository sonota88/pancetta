require_relative "helper"

require "pancetta/linter/checkstyle_utils"

class TestCheckstyleUtils < Minitest::Test

  XML = <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <checkstyle version="8.12">
      <file name="/path/to/Foo.java">
        <error line="18" column="44" severity="warning"
               message="WhitespaceAround: &apos;{&apos; is not preceded with whitespace."
               source="com.puppycrawl.tools.checkstyle.checks.whitespace.WhitespaceAroundCheck"
        />
      </file>
      <file name="/path/to/Bar.java">
        <error line="16" column="5" severity="warning" message="Javadoc コメントがありません。" source="com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocMethodCheck"/>
        <error line="22" column="5" severity="warning" message="Javadoc コメントがありません。" source="com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocMethodCheck"/>
      </file>
    </checkstyle>
  XML

  def test_parse
    issues = ::Pancetta::Linter::CheckstyleUtils.parse(XML)
    assert_equal(2, issues.size)
  end
end
