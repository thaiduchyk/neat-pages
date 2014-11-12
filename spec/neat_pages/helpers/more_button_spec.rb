require 'spec_helper'

describe NeatPages::Helpers::MoreButton do
  include ViewHelpers

  describe "#generate" do

    let(:pagination) { double() }

    context "with an empty pagination" do
      before { pagination.stub(:paginated?).and_return(false) }

      let(:builder) { NeatPages::Helpers::MoreButton.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to be_empty
      end
    end


    context "with pagination at 1 of 4" do
      before do
        pagination.stub(:paginated?).and_return(true)
        pagination.stub(:next?).and_return(true)
        pagination.stub(:next_page).and_return(2)
        pagination.stub(:total_pages).and_return(4)
      end

      let(:builder) { NeatPages::Helpers::MoreButton.new(pagination, request_mock) }

      specify "when generating button" do
        expect(builder.generate('plus', 'fin')).to eql '<div id="neat-pages-more-button" data-next-page="2" data-total-pages="4">' +
          '<a href="http://test.dev?page=2">plus</a><div class="over">fin</div></div>'
      end
    end
  end
end
