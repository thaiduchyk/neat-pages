require 'spec_helper'

describe NeatPages::Helpers::Status do
  include ViewHelpers

  describe "#generate" do

    let(:pagination) { double() }

    context "with an empty pagination" do
      before { pagination.stub(:empty?).and_return(true) }

      let(:builder) { NeatPages::Helpers::Status.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to be_empty
      end
    end

    context "with a pagination out of bound" do
      before do
        pagination.stub(:empty?).and_return(false)
        pagination.stub(:out_of_bound?).and_return(true)
      end

      let(:builder) { NeatPages::Helpers::Status.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to be_empty
      end
    end

    context "with a 100 items pagination starting at 20 and having 10 items per page" do
      before do
        pagination.stub(:empty?).and_return(false)
        pagination.stub(:out_of_bound?).and_return(false)
        pagination.stub(:offset).and_return(20)
        pagination.stub(:per_page).and_return(10)
        pagination.stub(:total_items).and_return(100)
      end

      let(:builder) { NeatPages::Helpers::Status.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to eql '<span data-neat-pages-control="status" id="neat-pages-status"><span class="from">21</span> to <span class="to">30</span>/<span class="total">100</span></span>'
      end
    end

    context "with a 23 items pagination starting at 20 and having 10 items per page" do
      before do
        pagination.stub(:empty?).and_return(false)
        pagination.stub(:out_of_bound?).and_return(false)
        pagination.stub(:offset).and_return(20)
        pagination.stub(:per_page).and_return(10)
        pagination.stub(:total_items).and_return(23)
      end

      let(:builder) { NeatPages::Helpers::Status.new(pagination, request_mock) }

      specify "when generating the status" do
        expect(builder.generate).to eql '<span data-neat-pages-control="status" id="neat-pages-status"><span class="from">21</span> to <span class="to">23</span>/<span class="total">23</span></span>'
      end
    end
  end
end
