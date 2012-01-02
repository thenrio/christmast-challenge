require 'spec_helper'
require 'defunkt'
require 'rules'

module Fame
  describe Rule do
    it "evaluates a simple statement" do
      r = Rule.new("commit = 1")
      r.score({"commits" => 100}).must_equal({commit: 100})
    end
    it "evaluates an additive statement" do
      r = Rule.new("commit += 1")
      r.score({"commits" => 1}, {commit: 100}).must_equal({commit: 101})
    end
  end
end
