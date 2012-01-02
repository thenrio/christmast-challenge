require 'spec_helper'
require 'defunkt'
require 'rules'

module Fame
  describe Rule do
    it "evaluates a statement" do
      r = Rule.new("commit = 1")
      r.score({"commits" => 100}).must_equal({commit: 100})
    end
  end
end
