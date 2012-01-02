require 'spec_helper'
require 'defunkt'
require 'rules'

module Fame
  describe Rule do
    include Defunkt
    it "evaluates a statement" do
      r = Rule.new("commit = 1")
      r.score(defunkt).must_equal 8901
    end
  end
end
