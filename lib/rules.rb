module Fame
  class Rule
    attr_reader :attribute, :expression
    def initialize(statement)
      @attribute, *@expression = statement.split(/\s/)
    end

    def score(profile, score={})
      if @attribute == :repository
        scores = score[:repositories] ||= {}
        score[:repositories] = profile["repositories"].reduce(scores) do |acc, r|
          acc.instance_eval(statement(r["name"].to_sym, @op, @score, 1))
          acc
        end
      else
        op, points, *tail = expression
        count = profile[pluralize(attribute)]
        statement = "self[:#{attribute}] #{op} #{count} * #{points}"
        score.instance_eval(statement)
      end
      score
    end

    def statement(attribute, op, score, count)
      "self[:#{attribute}] #{op} #{score} * #{count}"
    end

    def pluralize(attribute)
      "#{attribute}s"
    end
  end
end