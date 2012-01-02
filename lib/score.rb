module Fame
  def score(profile, rules)
    rules.reduce(0) do |rule|
      rule.score(profile)
    end
  end
  module_function :score
end