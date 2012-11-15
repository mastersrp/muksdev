require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class ThreadTest < Test::Unit::TestCase
  context "Thread Model" do
    should 'construct new instance' do
      @thread = Thread.new
      assert_not_nil @thread
    end
  end
end
