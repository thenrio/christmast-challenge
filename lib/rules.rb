module Fame
  class Rule
    def initialize(statement)
      attribute, @op, score = (%r(^(\w+) ([\+=]+) (\d+)).match(statement)[1..3])
      @score = score.to_i
      @attribute = attribute.to_sym
    end

    def score(profile, score={})
      if @attribute == :repository
        score[:repository] = profile["repositories"].reduce({}) do |acc, r|
          acc[r["name"].to_sym] = @score
          acc
        end
      else
        eval("score[:#{@attribute}] #{@op} #{profile[pluralize(@attribute)]} * #{@score}")
      end
      score
    end

    def pluralize(attribute)
      "#{attribute}s"
    end
  end
end