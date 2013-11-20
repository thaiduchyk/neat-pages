require 'spec_helper'

describe NeatPages::Base do
  #*************************************************************************************
  # PUBLIC INSTANCE METHODS
  #*************************************************************************************
  describe "#empty?" do
    context "with a 20 items pagination" do
      specify { NeatPages::Base.new(0, total_items: 20).should_not be_empty }
    end

    context "with a 0 item pagination" do
      specify { NeatPages::Base.new(0).should be_empty }
    end
  end

  describe "#next_page" do
    context "with a 100 items pagination starting at 0 and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 100).next_page.should eql 2 }
    end

    context "with a 100 items pagination starting at page 3 and having 15 items per page" do
      specify { NeatPages::Base.new(3, per_page: 15, total_items: 100).next_page.should eql 4 }
    end

    context "with a 5 items pagination starting at 0 and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 5).next_page.should eql 1 }
    end
  end

  describe "#next?" do
    context "with a 100 items pagination starting at 0 and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 100).should be_next }
    end

    context "with a 5 items pagination starting at 0 and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 5).should_not be_next }
    end
  end

  describe "#offset" do
    context "with a 100 items pagination starting at page 1 and having 10 items per page" do
      specify { NeatPages::Base.new(1, per_page: 10, total_items: 100).offset.should eql 0 }
    end

    context "with a 100 items pagination starting at page 4 and having 15 items per page" do
      specify { NeatPages::Base.new(4, per_page: 15, total_items: 100).offset.should eql 45 }
    end

    context "with a 100 items pagination starting at page 999 and having 15 items per page" do
      specify { NeatPages::Base.new(999, per_page: 15, total_items: 100).offset.should eql 101 }
    end
  end

  describe "#out_of_bound?" do
    context "with a 100 items pagination starting at page 1 and having 10 items per page" do
      specify { NeatPages::Base.new(1, per_page: 10, total_items: 100).should_not be_out_of_bound }
    end

    context "with a 100 items pagination starting at page 11 and having 10 items per page" do
      specify { NeatPages::Base.new(11, per_page: 10, total_items: 100).should be_out_of_bound }
    end
  end

  describe "#previous_page" do
    context "with a 100 items pagination starting at page 5 and having 10 items per page" do
      specify { NeatPages::Base.new(5, per_page: 10, total_items: 100).previous_page.should eql 4 }
    end

    context "with a 100 items pagination starting at page 3 and having 15 items per page" do
      specify { NeatPages::Base.new(3, per_page: 15, total_items: 100).previous_page.should eql 2 }
    end

    context "with a 50 items pagination starting at 0 and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 50).previous_page.should eql 1 }
    end
  end

  describe "#previous" do
    context "with a 100 items pagination starting at page 5 and having 10 items per page" do
      specify { NeatPages::Base.new(5, per_page: 10, total_items: 100).should be_previous }
    end

    context "with a 50 items pagination starting at 0 and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 50).should_not be_previous }
    end
  end

  describe "#previous?" do
    context "with a 100 items pagination starting at 0 and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 100).should_not be_previous }
    end

    context "with a 100 items pagination starting at page 2 and having 10 items per page" do
      specify { NeatPages::Base.new(2, per_page: 10, total_items: 100).should be_previous }
    end

    context "with a 5 items pagination starting at 0 and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 5).should_not be_previous }
    end
  end

  describe "#response_headers" do
    context "with a 200 items pagination starting at page 1 and having 10 items per page" do
      subject { NeatPages::Base.new(1, per_page: 10, total_items: 200).response_headers }

      its(:length) { should eql 4 }
      its(['X-Total-Items']) { should eql '200' }
      its(['X-Total-Pages']) { should eql '20' }
      its(['X-Per-Page']) { should eql '10' }
      its(['X-Current-Page']) { should eql '1' }
    end
  end

  describe "#total_pages" do
    context "with a 100 items pagination and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10, total_items: 100).total_pages.should eql 10 }
    end

    context "with a 0 items pagination and having 10 items per page" do
      specify { NeatPages::Base.new(0, per_page: 10).total_pages.should eql 1 }
    end
  end
end
