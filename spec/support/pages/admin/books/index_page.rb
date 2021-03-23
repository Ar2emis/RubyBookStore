module Admin
  module Books
    class IndexPage < SitePrism::Page
      set_url '/admin/books'

      section :batch_actions, 'div.batch_actions_selector' do
        element :delete_selected, 'a[data-action="destroy"]'
      end

      section :popup, 'div[role="dialog"]' do
        element :ok, :xpath, '//button[text()="OK"]'
      end

      section :table, '#index_table_books' do
        section :body, 'tbody' do
          sections :rows, 'tr' do
            element :checkbox, 'input[type="checkbox"]'
          end
        end
      end
    end
  end
end
