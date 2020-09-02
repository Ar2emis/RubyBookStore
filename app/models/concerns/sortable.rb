module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    def ordered(param)
      method = "sort_#{param}".to_sym
      respond_to?(method) ? public_send(method) : order(nil)
    end
  end
end
