module Fame
  class Rule
    def initialize(statement)
      @attribute, score = (/^(\w+) = (\d+)/.match(statement)[1..2])
      @score = score.to_i
    end

    def score(profile)
      profile[pluralize(@attribute)] * @score
    end

    def pluralize(attribute)
      "#{attribute}s"
    end
  end
end