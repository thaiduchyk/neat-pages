require File.dirname(__FILE__) + '../../spec_helper'

describe NeatPages::Helpers do
  describe "#status" do
    context "with a 100 items pagination starting at 0 and having 10 items per page" do
      let(:neat_pages) { NeatPages::Base.new(0, :per_page => 10, :total_items => 100) }

      before { neat_pages.activate_helpers }

      specify { neat_pages.helpers.status.should eql "1 to 10/100" }
    end

    context "with a 23 items pagination starting at page 3 and having 10 items per page" do
      let(:neat_pages) { NeatPages::Base.new(3, :per_page => 10, :total_items => 23) }

      before { neat_pages.activate_helpers }

      specify { neat_pages.helpers.status.should eql "21 to 23/23" }
    end

    context "with a 0 items pagination starting at 0 and having 10 items per page" do
      let(:neat_pages) { NeatPages::Base.new(0, :per_page => 10, :total_items => 0) }

      before { neat_pages.activate_helpers }

      specify { neat_pages.helpers.status.should be_empty }
    end
  end
end
