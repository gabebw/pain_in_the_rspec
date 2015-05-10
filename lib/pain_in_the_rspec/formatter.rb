module PainInTheRspec
  class Formatter < RSpec::Core::Formatters::DocumentationFormatter
    RSpec::Core::Formatters.register Formatter, :example_passed, :example_failed
  end
end
