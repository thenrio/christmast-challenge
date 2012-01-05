require 'rules'

module Fame
  class Engine
    attr_reader :rules
    def initialize(rules)
      @rules = rules.split("\n").map { |rule| Rule.new(rule) }.group_by { |r| r.attribute }
    end

    def compute(profile)
      mappings.reduce({}) do |scores, (attribute, key)|
        rules = self.rules[attribute] || []
        [profile[key]].flatten.reduce(scores) { |acc, oo| apply(acc, rules, oo) }
      end
    end

    def score(profile)
      compute(profile).reduce(0) { |sum, (_k, v)| sum += v }
    end

    private
    def apply(scores, rules, o)
      rules.reduce(scores) { |acc, r| r.score(o, acc) }
    end

    def mappings
      {commit: "commits", follower: "followers", repository: "repositories"}
    end
  end
end