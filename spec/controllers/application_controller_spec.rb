require "spec_helper"

describe ApplicationController, type: :controller do
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
      expect(controller.pagination.per_page).to eql 20
      expect(response.headers["X-Per-Page"]).to eql "20"
    end
  end
end
