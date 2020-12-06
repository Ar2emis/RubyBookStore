module PresenterHelpers
  class FakeView
    include ActionView::Helpers::TextHelper
  end

  def fake_view
    FakeView.new
  end
end

RSpec.configure do |config|
  config.include PresenterHelpers
end
