class BookPresenter < BasePresenter
  SHORT_DESCRIPTION_MAX_LENGTH = 250

  def authors_names
    @model.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end

  def description_long?
    @model.description.length > SHORT_DESCRIPTION_MAX_LENGTH
  end

  def short_description
    @view.truncate(@model.description, length: SHORT_DESCRIPTION_MAX_LENGTH)
  end
end
