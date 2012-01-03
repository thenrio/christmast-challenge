require 'rules'

module Fame
  class Engine
    attr_reader :rules
    def initialize(rules)
      @rules = rules.split("\n").map { |rule| Rule.new(rule) }.group_by { |r| r.attribute }
    end

    def score(profile)
      scores = {commit: "commits", follower: "followers", repository: "repositories"}.reduce({}) do |scores, (attribute, key)|
        rules = self.rules[attribute] || []
        rules.reduce(scores) { |acc, r| r.score(profile[key], scores) }
      end
      scores.reduce(0) { |sum, (_k, v)| sum += v }
    end
  end
end