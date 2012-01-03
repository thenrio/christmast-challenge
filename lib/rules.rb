require 'ostruct'

module Fame
  class Rule
    attr_reader :attribute, :expression
    def initialize(statement)
      @attribute, *@expression = statement.split(/\s/)
    end

    def score(object, score={})
      op, points, *tail = expression
      if attribute.to_sym == :repository
        repository = OpenStruct.new(object)
        statement = (["score[:#{repository.name}] #{op} #{points}"] + tail).join(" ")
        eval(statement)
      else
        count = object
        statement = "self[:#{attribute}] #{op} #{count} * #{points}"
        score.instance_eval(statement)
      end
      score
    end

    def pluralize(attribute)
      "#{attribute}s"
    end
  end
end