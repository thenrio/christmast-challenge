module Defunkt
  def defunkt
    @defunkt ||= {
    "login" => "defunkt",
    "followers" => 4674,
    "commits" => 8901,
    "repositories" => [{
      "watchers" => 79,
      "forks" => 9,
      "name" => "choice"
      }, {
      "watchers" => 28,
      "forks" => 1,
      "name" => "mapreducerb"
      }, {
      "watchers" => 16,
      "forks" => 3,
      "name" => "ambitious_activerecord"
      }, {
      "watchers" => 151,
      "forks" => 39,
      "name" => "emacs"
      }, {
      "watchers" => 787,
      "forks" => 116,
      "name" => "github-gem"
      }, {
      "watchers" => 1559,
      "forks" => 298,
      "name" => "facebox"
      }, {
      "watchers" => 2977,
      "forks" => 425,
      "name" => "resque"
      }]
    }
  end
  alias_method :profile, :defunkt
  module_function :profile
end