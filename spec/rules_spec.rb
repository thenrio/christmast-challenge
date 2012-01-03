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

    describe " on a repository" do
      it "evaluates a simple statement" do
        r = Rule.new("repository = 1")
        trollz = {"watchers" => 1, "forks" => 0, "name" => "trollz"}
        r.score({"repositories" => [trollz]}).must_equal({repositories: {trollz: 1}})
      end
      it "evaluates an additive statement" do
        r = Rule.new("repository += 1")
        trollz = {"watchers" => 1, "forks" => 0, "name" => "trollz"}
        r.score({"repositories" => [trollz]}, {repositories: {trollz: 1}}).must_equal({repositories: {trollz: 2}})
      end
    end
  end
end
