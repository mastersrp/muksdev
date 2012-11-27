require File.expand_path(File.dirname(__FILE__) + '/../../test_config.rb')

class ArticleTest < Test::Unit::TestCase
  context "Article Model" do
    should 'construct new instance' do
      @article = Article.new
      assert_not_nil @article
    end
  end
end
