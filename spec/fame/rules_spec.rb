require 'spec_helper'
require 'fame/defunkt'
require 'fame/rules'

module Fame
  describe Rule do
    it "evaluates a simple statement" do
      r = Rule.new("commit = 1")
      r.score(100).must_equal({commit: 100})
    end
    it "evaluates an additive statement" do
      r = Rule.new("commit += 1")
      r.score(1, {commit: 100}).must_equal({commit: 101})
    end

    describe " on a repository" do
      it "evaluates a simple statement" do
        r = Rule.new("repository = 1")
        trollz = {"watchers" => 1, "forks" => 0, "name" => "trollz"}
        r.score(trollz).must_equal({trollz: 1})
      end
      it "evaluates an additive statement" do
        r = Rule.new("repository += 1")
        trollz = {"watchers" => 1, "forks" => 0, "name" => "trollz"}
        r.score(trollz, {trollz: 1}).must_equal({trollz: 2})
      end
      it "evaluates a true condition (watchers > 5 when watchers = 10)" do
        r = Rule.new("repository = 10 if repository.watchers > 5")
        trollz = {"watchers" => 10, "forks" => 0, "name" => "trollz"}
        r.score(trollz).must_equal({trollz: 10})
      end
    end
  end
end
