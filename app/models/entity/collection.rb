module Entity
  class Collection
    include Enumerable

    def initialize(meta:, entities:)
      @meta = meta
      @entities = entities
    end

    def each
      @entities.each { |entity| yield entity }
    end

    def all
      @entities
    end

    def page
      @meta['page']
    end

    def last_page?
      !@meta['next_page']
    end

    def first_page?
      page == 1
    end

    def next_page
      last_page? ? nil : page + 1
    end

    def prev_page
      first_page? ? nil : page - 1
    end

    def from
      @meta['from']
    end

    def to
      @meta['to']
    end

    def per
      (to - from) + 1
    end
  end
end
