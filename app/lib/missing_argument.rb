module Madsen
  class MissingArgument < Exception

    attr_reader :fields

    def initialize(*fields)
      @fields = fields
    end

    def to_s
      "You are missing the following required fields: #{@fields.join(", ")}"
    end

  end
end