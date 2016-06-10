require 'rails_helper'

describe YelpService do
  before do
    @service = Yelp.client
  end

  it "#search" do
    VCR.use_cassette("search api", record: :new_episodes) do
      params = { term: 'Two Rivers Coffee',
                 limit: 1}
      a = @service.business("two-rivers-coffee-arvada-2")
      require 'pry'; binding.pry
    end
  end
end
