require "spec_helper"
require "stringio"

describe PainInTheRspec::Formatter do
  let(:output) { StringIO.new }

  it "prints out a pun when an example fails" do
    pundit = instance_double(PainInTheRspec::Pundit)
    allow(pundit).to receive(:pun).and_return("pain in the neck")
    allow(PainInTheRspec::Pundit).to receive(:new).with("rspec").and_return(pundit)

    example = double(
      "example",
      description: "rspec",
      execution_result: execution_result(status: :failed, exception: Exception.new)
    )

    allow(RSpec.configuration).to receive(:color_enabled?).and_return(false)
    setup_reporter

    send_notification(:example_failed, example_notification(example))

    expect(output.string).to include "pain in the neck"
  end

  def execution_result(values)
    RSpec::Core::Example::ExecutionResult.new.tap do |er|
      values.each { |name, value| er.__send__(:"#{name}=", value) }
    end
  end

  def example_notification(example)
    ::RSpec::Core::Notifications::ExampleNotification.for example
  end

  def new_example(description, metadata = {})
    metadata = metadata.dup
    result = RSpec::Core::Example::ExecutionResult.new
    result.started_at = ::Time.now
    result.record_finished(metadata.delete(:status) { :passed }, ::Time.now)
    result.exception = Exception.new if result.status == :failed

    instance_double(
      RSpec::Core::Example,
      description: description,
      full_description: description,
      execution_result: result,
      location: "",
      location_rerun_argument: "",
      metadata: { shared_group_inclusion_backtrace: [] }.merge(metadata)
    )
  end

  def formatter
    @formatter ||= setup_reporter
  end

  def setup_reporter
    config.add_formatter described_class
    @reporter = config.reporter
    config.formatters.first
  end

  def send_notification(type, notification)
    @reporter.notify(type, notification)
  end

  def config
    @configuration ||=
      begin
        config = RSpec::Core::Configuration.new
        config.output_stream = output
        config.color = false
        config
      end
  end
end
