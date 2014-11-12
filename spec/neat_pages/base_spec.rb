require 'spec_helper'

describe NeatPages::Base do
  describe "#empty?" do
    specify "with a 20 items pagination" do
      expect(NeatPages::Base.new(0, total_items: 20)).not_to be_empty
    end

    specify "with a 0 item pagination" do
      expect(NeatPages::Base.new(0)).to be_empty
    end
  end

  describe "#limit" do
    specify "with a 100 items pagination starting at 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 100).limit).to eql 10
    end
  end

  describe "#next_page" do
    specify "with a 100 items pagination starting at 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 100).next_page).to eql 2
    end

    specify "with a 100 items pagination starting at page 3 and having 15 items per page" do
      expect(NeatPages::Base.new(3, per_page: 15, total_items: 100).next_page).to eql 4
    end

    specify "with a 5 items pagination starting at 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 5).next_page).to eql 1
    end
  end

  describe "#next?" do
    specify "with a 100 items pagination starting at 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 100)).to be_next
    end

    specify "with a 5 items pagination starting at 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 5)).not_to be_next
    end
  end

  describe "#offset" do
    specify "with a 100 items pagination starting at page 1 and having 10 items per page" do
      expect(NeatPages::Base.new(1, per_page: 10, total_items: 100).offset).to eql 0
    end

    specify "with a 100 items pagination starting at page 4 and having 15 items per page" do
      expect(NeatPages::Base.new(4, per_page: 15, total_items: 100).offset).to eql 45
    end

    specify "with a 100 items pagination starting at page 999 and having 15 items per page" do
      expect(NeatPages::Base.new(999, per_page: 15, total_items: 100).offset).to eql 101
    end
  end

  describe "#out_of_bound?" do
    specify "with a 100 items pagination starting at page 1 and having 10 items per page" do
      expect(NeatPages::Base.new(1, per_page: 10, total_items: 100)).not_to be_out_of_bound
    end

    specify "with a 100 items pagination starting at page 11 and having 10 items per page" do
      expect(NeatPages::Base.new(11, per_page: 10, total_items: 100)).to be_out_of_bound
    end
  end

  describe "#paginated?" do
    specify "with a 20 items pagination starting at page 1 and having 10 items per page" do
      expect(NeatPages::Base.new(1, per_page: 10, total_items: 20)).to be_paginated
    end

    specify "with a 5 items pagination starting at page 1 and having 10 items per page" do
      expect(NeatPages::Base.new(1, per_page: 10, total_items: 5)).not_to be_paginated
    end
  end

  describe "#previous_page" do
    specify "with a 100 items pagination starting at page 5 and having 10 items per page" do
      expect(NeatPages::Base.new(5, per_page: 10, total_items: 100).previous_page).to eql 4
    end

    specify "with a 100 items pagination starting at page 3 and having 15 items per page" do
      expect(NeatPages::Base.new(3, per_page: 15, total_items: 100).previous_page).to eql 2
    end

    specify "with a 50 items pagination starting at 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 50).previous_page).to eql 1
    end
  end

  describe "#previous" do
    specify "with a 100 items pagination starting at page 5 and having 10 items per page" do
      expect(NeatPages::Base.new(5, per_page: 10, total_items: 100)).to be_previous
    end

    specify "with a 50 items pagination starting at 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 50)).not_to be_previous
    end
  end

  describe "#previous?" do
    specify "with a 100 items pagination starting at 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 100)).not_to be_previous
    end

    specify "with a 100 items pagination starting at page 2 and having 10 items per page" do
      expect(NeatPages::Base.new(2, per_page: 10, total_items: 100)).to be_previous
    end

    specify "with a 5 items pagination starting at page 0 and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 5)).not_to be_previous
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

  describe "#set_total_items" do
    context "with a 100 items pagination starting at page 2 and having 10 items per page" do
      let(:pagination) { NeatPages::Base.new(2, per_page: 10, total_items: 100) }

      context "when changing the total items to 5" do
        before { pagination.set_total_items 5 }

        it { expect(pagination).to be_out_of_bound }
        it { expect(pagination.total_items).to eql 5 }
      end
    end
  end

  describe "#total_pages" do
    specify "with a 100 items pagination and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10, total_items: 100).total_pages).to eql 10
    end

    specify "with a 0 items pagination and having 10 items per page" do
      expect(NeatPages::Base.new(0, per_page: 10).total_pages).to eql 1
    end
  end
end
