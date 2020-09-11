class BooksPresenter < BasePresenter
  attr_reader :books, :categories

  SORT_PARAMETERS = {
    newest: 'books.sort.newest',
    cheap: 'books.sort.cheap',
    expensive: 'books.sort.expensive',
    atoz: 'books.sort.atoz',
    ztoa: 'books.sort.ztoa'
  }.freeze

  def initialize(books:, categories:, params:)
    super()
    @books = books
    @categories = categories
    @params = params
  end

  def sort_parameters
    SORT_PARAMETERS
  end

  def current_category
    current_category = @categories.detect { |category| category.id == @params[:category].to_i }
    current_category.present? ? current_category.name : I18n.t('categories.all')
  end

  def display_params(sort: @params[:sort], category: @params[:category])
    { sort: sort, category: category }
  end

  def current_sort
    @params[:sort].present? ? SORT_PARAMETERS.fetch(@params[:sort].to_sym, :newest) : SORT_PARAMETERS[:newest]
  end
end
