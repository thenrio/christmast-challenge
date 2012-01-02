module Fame
  class Rule
    def initialize(statement)
      @attribute, @op, score = (%r(^(\w+) ([\+=]+) (\d+)).match(statement)[1..3])
      @score = score.to_i
    end

    def score(profile, score={})
      eval("score[:#{@attribute.to_sym}] #{@op} #{profile[pluralize(@attribute)]} * @score")
      score
    end

    def pluralize(attribute)
      "#{attribute}s"
    end
  end
end