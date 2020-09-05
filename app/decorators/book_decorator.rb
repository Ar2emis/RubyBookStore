class BookDecorator < ApplicationDecorator
  delegate_all

  def authors_names
    object.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end
end
