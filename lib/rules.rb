require 'ostruct'

module Fame
  class Rule
    attr_reader :attribute, :expression
    def initialize(statement)
      attribute, *@expression = statement.split(/\s/)
      @attribute = attribute.to_sym
    end

    def score(object, score={})
      op, points, *tail = expression
      if repository?
        repository = OpenStruct.new(object)
        statement = (["score[:#{repository.name}] #{op} #{points}"] + tail).join(" ")
        eval(statement)
      else
        count = object
        statement = "score[:#{attribute}] #{op} #{count} * #{points}"
        eval(statement)
      end
      score
    end

    private
    def repository?
      attribute.to_sym == :repository
    end
  end
end