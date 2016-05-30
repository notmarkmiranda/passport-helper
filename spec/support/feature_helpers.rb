module FeatureHelpers
  def login_with_oauth
    visit "/auth/facebook"
  end
end
