require 'spec_helper'

describe NeatPages::Helpers::Relation do
  include ViewHelpers

  describe "#generate" do

    let(:pagination) { double() }

    context "with pagination at 1 of 4" do
      before do
        pagination.stub(:paginated?).and_return(true)
        pagination.stub(:current_page).and_return(1)
        pagination.stub(:next?).and_return(true)
        pagination.stub(:next_page).and_return(2)
        pagination.stub(:previous?).and_return(false)
        pagination.stub(:total_pages).and_return(4)
      end

      let(:builder) { NeatPages::Helpers::Relation.new(pagination, request_mock) }

      specify "when generating relations" do
        expect(builder.generate).to eql "<link rel=\"next\" href=\"http://test.dev?page=2\"/>\n"
      end
    end

    context "with pagination at 2 of 4" do
      before do
        pagination.stub(:paginated?).and_return(true)
        pagination.stub(:current_page).and_return(1)
        pagination.stub(:next?).and_return(true)
        pagination.stub(:next_page).and_return(3)
        pagination.stub(:previous?).and_return(true)
        pagination.stub(:previous_page).and_return(1)
        pagination.stub(:total_pages).and_return(4)
      end

      let(:builder) { NeatPages::Helpers::Relation.new(pagination, request_mock) }

      specify "when generating relations" do
        expect(builder.generate).to eql "<link rel=\"prev\" href=\"http://test.dev?page=1\"/>\n<link rel=\"next\" href=\"http://test.dev?page=3\"/>\n"
      end
    end

    context "with pagination at 4 of 4" do
      before do
        pagination.stub(:paginated?).and_return(true)
        pagination.stub(:current_page).and_return(4)
        pagination.stub(:next?).and_return(false)
        pagination.stub(:previous?).and_return(true)
        pagination.stub(:previous_page).and_return(3)
        pagination.stub(:total_pages).and_return(4)
      end

      let(:builder) { NeatPages::Helpers::Relation.new(pagination, request_mock) }

      specify "when generating relations" do
        expect(builder.generate).to eql "<link rel=\"prev\" href=\"http://test.dev?page=3\"/>\n"
      end
    end

  end
end
