require "spec_helper"

describe ApplicationController do
  controller do
    def index
      paginate per_page: 20

      set_pagination_header

      raise NeatPages::OutOfBound
    end
  end

  describe "#index" do
    it 'is out of bound' do
      get :index

      expect(response.status).to eq(404)
      expect(response.body).to eq "out_of_bound"
      controller.pagination.per_page.should eql 20
      response.headers["X-Per-Page"].should eql "20"
    end
  end
end
