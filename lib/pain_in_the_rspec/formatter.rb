require "rspec/core"
require "pain_in_the_rspec"

module PainInTheRspec
  class Formatter < RSpec::Core::Formatters::DocumentationFormatter
    RSpec::Core::Formatters.register self, :example_passed, :example_pending,
      :example_failed

    def example_failed(failure)
      output.puts failure_output(
        failure.example,
        failure.example.execution_result.exception
      )
    end

    def example_passed(passed)
      output.puts passed_output(passed.example)
    end

    private

    def passed_output(example)
      wrap(pun_description(example), :success)
    end

    def pending_output(example, message)
      wrap(
        "#{pun_description(example)} (PENDING: #{message})",
        :pending
      )
    end

    def failure_output(example, _exception)
      message = pun_description(example)

      wrap(
        "#{message} (FAILED - #{next_failure_index})",
        :failure
      )
    end

    def pun_description(example)
      current_indentation +
        Pundit.new(example.description.strip).pun
    end

    def wrap(message, status)
      RSpec::Core::Formatters::ConsoleCodes.wrap(message, status)
    end
  end
end
