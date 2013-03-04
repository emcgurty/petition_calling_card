  class SortCriteria
    # TOTO Sort table column

    attr_accessor :sort_column, :sort_order
    
    def initialize(column, order)
      @sort_column = column
      @sort_order = order
    end
  end