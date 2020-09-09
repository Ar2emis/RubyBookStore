class BooksPresenter < Rectify::Presenter
  attribute :books, Array[BookDecorator]
  attribute :categories, Array[Category]

  SORT_PARAMETERS = {
    newest: 'books.sort.newest',
    cheap: 'books.sort.cheap',
    expensive: 'books.sort.expensive',
    atoz: 'books.sort.atoz',
    ztoa: 'books.sort.ztoa'
  }.freeze
  ALL_BOOKS_CATEGORY = I18n.t('categories.all')
  START_NEXT_COUNT = 2
  STANDARD_SORT = :newest

  def sort_parameters
    SORT_PARAMETERS
  end

  def no_category_chosen?
    params[:category].nil?
  end

  def current_category?(category)
    params[:category].to_i == category.id
  end

  def current_category
    current_category = @categories.detect { |category| category.id == params[:category].to_i }
    current_category.present? ? current_category.name : ALL_BOOKS_CATEGORY
  end

  def display_params(sort: params[:sort], category: params[:category])
    { sort: sort, category: category }
  end

  def current_sort
    params[:sort].present? ? SORT_PARAMETERS.fetch(params[:sort].to_sym, :newest) : SORT_PARAMETERS[:newest]
  end

  def all_books_count
    Book.all.count
  end
end
