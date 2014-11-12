require 'spec_helper'

describe NeatPages::Implants::ActiveRecordImplant do
  let(:pagination) { double() }
  let(:implant) { Module.new { extend NeatPages::Implants::ActiveRecordImplant } }

  describe "#paginate" do
    context "when the pagination isn't initialized" do
      it "raises" do
        expect { implant.paginate(nil) }.to raise_error NeatPages::Uninitalized
      end
    end

    context "when the page is out of bound" do
      before do
        implant.stub(:count)
        pagination.stub(:set_total_items)
        pagination.stub(:out_of_bound?).and_return true
      end

      it "raises" do
        expect { implant.paginate(pagination) }.to raise_error NeatPages::OutOfBound
      end
    end

    context "when asking for a page in bound" do
      before do
        implant.stub(:count)
        implant.stub(:limit).and_return('')
        implant.stub(:offset).and_return(implant)

        pagination.stub(:set_total_items)
        pagination.stub(:out_of_bound?).and_return false
        pagination.stub(:offset)
        pagination.stub(:limit)
      end

      it { expect(implant.paginate(pagination)).to eql '' }
    end

  end
end

