require 'rules'

module Fame
  class Engine
    def initialize(rules)
      @rules = rules.split("\n").map { |rule| Rule.new(rule) }
    end

    def score(profile)
      score = @rules.reduce({}) do |score, rule|
        rule.score(profile)
      end
      score.reduce(0) { |sum, (_k, v)| sum += v }
    end
  end
end