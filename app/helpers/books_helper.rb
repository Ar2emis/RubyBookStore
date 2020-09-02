module BooksHelper
  SORT_PARAMETERS = {
    newest: 'books.sort.newest',
    cheap: 'books.sort.cheap',
    expensive: 'books.sort.expensive',
    atoz: 'books.sort.atoz',
    ztoa: 'books.sort.ztoa'
  }.freeze
  ALL_BOOKS_CATEGORY = I18n.t('categories.all')

  def query_params(count: nil, sort: params[:sort], category: params[:category])
    { count: count, sort: sort, category: category }
  end

  def sort_parameters
    SORT_PARAMETERS
  end

  def current_sort
    sort_param = params[:sort]
    sort_key = sort_param.present? && SORT_PARAMETERS.key?(sort_param.to_sym) ? sort_param.to_sym : :newest
    SORT_PARAMETERS[sort_key]
  end

  def current_category
    category_id = params[:category]
    category_valid?(category_id) ? Category.find(category_id).name : ALL_BOOKS_CATEGORY
  end

  def category_valid?(category_id)
    category_id.present? && Category.exists?(category_id)
  end

  def next_count
    count = params[:count]
    count.present? ? count.to_i.next : 2
  end
end
