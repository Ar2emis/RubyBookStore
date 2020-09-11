class BasePresenter
  private

  def view
    @view ||= ActionView::Base.new
  end
end
