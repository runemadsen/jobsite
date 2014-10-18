module Madsen
  class WrongArgument < Exception

    attr_reader :fields

    def initialize(*fields)
      @fields = fields
    end

    def to_s
      "The following fields have incorrect values: #{@fields.join(", ")}"
    end

  end
end