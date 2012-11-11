require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class SubscriberTest < Test::Unit::TestCase
  context "Subscriber Model" do
    should 'construct new instance' do
      @subscriber = Subscriber.new
      assert_not_nil @subscriber
    end
  end
end
