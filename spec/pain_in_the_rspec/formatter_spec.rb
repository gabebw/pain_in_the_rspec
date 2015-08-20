require "spec_helper"
require "stringio"

describe PainInTheRspec::Formatter do
  let(:output) { StringIO.new }
  let(:original) { "rspec" }
  let(:pun_of_original) { "pain in the neck" }

  before do
    setup_reporter
  end

  it "prints out a pun when an example fails" do
    stub_pun(original => pun_of_original)

    send_notification(
      :example_failed,
      example_notification(failed_example(original))
    )

    expect(output.string).to include pun_of_original
  end

  it "prints out a pun when an example passes" do
    stub_pun(original => pun_of_original)

    send_notification(
      :example_passed,
      example_notification(passed_example(original))
    )

    expect(output.string).to include pun_of_original
  end

  it "prints out a pun when an example is pending" do
    stub_pun(original => pun_of_original)

    send_notification(
      :example_pending,
      example_notification(pending_example(original))
    )

    expect(output.string).to include pun_of_original
  end

  def passed_example(description)
    generic_example(description, :passed)
  end

  def pending_example(description)
    generic_example(description, :pending)
  end

  def failed_example(description)
    generic_example(description, :failed).tap do |example|
      example.execution_result.exception = Exception.new
    end
  end

  def generic_example(description, status)
    double(
      "example",
      description: description,
      full_description: description,
      execution_result: execution_result(status: status)
    )
  end

  def execution_result(values)
    RSpec::Core::Example::ExecutionResult.new.tap do |er|
      values.each { |name, value| er.__send__(:"#{name}=", value) }
    end
  end

  def send_notification(type, notification)
    reporter.notify(type, notification)
  end

  def example_notification(example)
    ::RSpec::Core::Notifications::ExampleNotification.for example
  end

  def formatter
    @formatter ||= config.formatters.first
  end

  def reporter
    @reporter
  end

  def setup_reporter
    @reporter = begin
      config.add_formatter described_class
      config.reporter
    end
  end


  def config
    @configuration ||= RSpec::Core::Configuration.new.tap do |config|
      config.output_stream = output
    end
  end

  def stub_pun(pun_hash)
    original = pun_hash.keys.first
    pun = pun_hash.values.first

    pundit = instance_double(PainInTheRspec::Pundit)
    allow(pundit).to receive(:pun).and_return(pun)
    allow(PainInTheRspec::Pundit).to receive(:new).
      with(original).
      and_return(pundit)
  end
end
