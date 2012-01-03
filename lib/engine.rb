require 'rules'

module Fame
  class Engine
    attr_reader :rules
    def initialize(rules)
      @rules = rules.split("\n").map { |rule| Rule.new(rule) }.group_by { |r| r.attribute }
    end

    def score(profile)
      scores = mappings.reduce({}) do |scores, (attribute, key)|
        rules = self.rules[attribute] || []
        o = profile[key]
        if o.is_a? Array
          o.reduce(scores) { |acc, oo| apply(acc, rules, oo) }
        else
          apply(scores, rules, o)
        end
      end
      puts scores
      scores.reduce(0) { |sum, (_k, v)| sum += v }
    end

    private
    def apply(scores, rules, o)
      rules.reduce(scores) { |acc, r| r.score(o, scores) }
    end

    def mappings
      {commit: "commits", follower: "followers", repository: "repositories"}
    end
  end
end