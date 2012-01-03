module Fame
  class Rule
    def initialize(statement)
      attribute, @op, score = (%r(^(\w+) ([\+=]+) (\d+)).match(statement)[1..3])
      @score = score.to_i
      @attribute = attribute.to_sym
    end

    def score(profile, score={})
      if @attribute == :repository
        scores = score[:repositories] ||= {}
        score[:repositories] = profile["repositories"].reduce(scores) do |acc, r|
          acc.instance_eval(statement(r["name"].to_sym, @op, @score, 1))
          acc
        end
      else
        score.instance_eval(statement(@attribute, @op, @score, profile[pluralize(@attribute)]))
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