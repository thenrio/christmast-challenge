require 'spec_helper'
require 'defunkt'
require 'engine'

module Fame
  describe Engine do
    it "scores 100, when 1 commit, each scoring 100" do
      coder = { "commits" => 1 }
      rules = <<-EOF
commit = 100
      EOF
      Engine.new(rules).score(coder).must_equal 100
    end

    it "scores 100, when 10 followers, each scoring 10" do
      coder = { "followers" => 10 }
      rules = <<-EOF
follower = 10
      EOF
      Engine.new(rules).score(coder).must_equal 100
    end

    describe "badass" do
      def badass
        {
          "repositories" => [{
            "watchers" => 1000,
            "forks" => 200,
            "name" => "resque"
          }]
        }
      end
      it "scores 100, when 10 followers, each scoring 10" do
        rules = <<-EOF
repository = 1
repository += repository.watchers
repository += 5 * repository.forks
        EOF
        Engine.new(rules).score(badass).must_equal 2001
      end
    end
  end
end
