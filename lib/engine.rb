require 'rules'

module Fame
  class Engine
    def initialize(rules)
      @rules = rules.split("\n").map { |rule| Rule.new(rule) }
    end

    def score(profile)
      @rules.reduce(0) do |score, rule|
        score += rule.score(profile)
      end
    end
  end
end