class BookDecorator < ApplicationDecorator
  delegate_all

  def authors_names
    object.authors.decorate.map(&:full_name).join(', ')
  end
end
