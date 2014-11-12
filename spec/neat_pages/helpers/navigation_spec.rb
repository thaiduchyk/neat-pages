require 'spec_helper'

describe NeatPages::Helpers::Navigation do
  include ViewHelpers

  describe "#generate" do

    let(:pagination) { double() }

    context "with a pagination that doesn't need pages" do
      before { pagination.stub(:paginated?).and_return(false) }

      let(:builder) { NeatPages::Helpers::Navigation.new(pagination, request_mock) }

      specify "when generating the navigation" do
        expect(builder.generate).to be_empty
      end
    end

    context "with a 40 items pagination starting at 20 and having 10 items per page" do
      before do
        pagination.stub(:paginated?).and_return(true)
        pagination.stub(:current_page).and_return(3)
        pagination.stub(:next?).and_return(true)
        pagination.stub(:next_page).and_return(4)
        pagination.stub(:offset).and_return(20)
        pagination.stub(:per_page).and_return(10)
        pagination.stub(:previous?).and_return(true)
        pagination.stub(:previous_page).and_return(2)
        pagination.stub(:total_items).and_return(40)
        pagination.stub(:total_pages).and_return(4)
      end

      let(:builder) { NeatPages::Helpers::Navigation.new(pagination, request_mock) }

      specify "when generating the navigation" do
        expect(builder.generate).to eql '<ul class="standard" id="neat-pages-navigation" data-neat-pages-control=="navigation" data-per-page="10" data-total-items="40" data-total-pages="4"><li class="move previous "><a data-page="2" href="http://test.dev?page=2" class="previous">&laquo; Previous</a></li><li class="page"><a data-page="1" href="http://test.dev?page=1">1</a></li><li class="page"><a data-page="2" href="http://test.dev?page=2">2</a></li><li class="page selected"><a data-page="3" href="http://test.dev?page=3">3</a></li><li class="page"><a data-page="4" href="http://test.dev?page=4">4</a></li><li class="move next "><a data-page="4" href="http://test.dev?page=4" class="next">Next &raquo;</a></li></ul>'
      end
    end

    context "with a 40 items pagination starting at 30 and having 10 items per page" do
      before do
        pagination.stub(:paginated?).and_return(true)
        pagination.stub(:current_page).and_return(3)
        pagination.stub(:next?).and_return(false)
        pagination.stub(:next_page).and_return(nil)
        pagination.stub(:offset).and_return(30)
        pagination.stub(:per_page).and_return(10)
        pagination.stub(:previous?).and_return(true)
        pagination.stub(:previous_page).and_return(2)
        pagination.stub(:total_items).and_return(40)
        pagination.stub(:total_pages).and_return(4)
      end

      let(:builder) { NeatPages::Helpers::Navigation.new(pagination, request_mock) }

      specify "when generating the navigation" do
        expect(builder.generate).to eql '<ul class="standard" id="neat-pages-navigation" data-neat-pages-control=="navigation" data-per-page="10" data-total-items="40" data-total-pages="4"><li class="move previous "><a data-page="2" href="http://test.dev?page=2" class="previous">&laquo; Previous</a></li><li class="page"><a data-page="1" href="http://test.dev?page=1">1</a></li><li class="page"><a data-page="2" href="http://test.dev?page=2">2</a></li><li class="page selected"><a data-page="3" href="http://test.dev?page=3">3</a></li><li class="page"><a data-page="4" href="http://test.dev?page=4">4</a></li><li class="move next disabled"><a data-page="#" href="#" class="next">Next &raquo;</a></li></ul>'
      end
    end

    context "with a 200 items pagination starting at 110 and having 10 items per page" do
      before do
        pagination.stub(:paginated?).and_return(true)
        pagination.stub(:current_page).and_return(12)
        pagination.stub(:next?).and_return(true)
        pagination.stub(:next_page).and_return(13)
        pagination.stub(:offset).and_return(110)
        pagination.stub(:per_page).and_return(10)
        pagination.stub(:previous?).and_return(true)
        pagination.stub(:previous_page).and_return(11)
        pagination.stub(:total_items).and_return(200)
        pagination.stub(:total_pages).and_return(20)
      end

      let(:builder) { NeatPages::Helpers::Navigation.new(pagination, request_mock) }

      specify "when generating the navigation" do
        expect(builder.generate).to eql '<ul class="standard" id="neat-pages-navigation" data-neat-pages-control=="navigation" data-per-page="10" data-total-items="200" data-total-pages="20">'+
          '<li class="move previous "><a data-page="11" href="http://test.dev?page=11" class="previous">&laquo; Previous</a></li>'+
          '<li class="page" style="display:none"><a data-page="1" href="http://test.dev?page=1">1</a></li>'+
          '<li class="page" style="display:none"><a data-page="2" href="http://test.dev?page=2">2</a></li>'+
          '<li class="page" style="display:none"><a data-page="3" href="http://test.dev?page=3">3</a></li>'+
          '<li class="page" style="display:none"><a data-page="4" href="http://test.dev?page=4">4</a></li>'+
          '<li class="page" style="display:none"><a data-page="5" href="http://test.dev?page=5">5</a></li>'+
          '<li class="page" style="display:none"><a data-page="6" href="http://test.dev?page=6">6</a></li>'+
          '<li class="page" style="display:none"><a data-page="7" href="http://test.dev?page=7">7</a></li>'+
          '<li class="page"><a data-page="8" href="http://test.dev?page=8">8</a></li>'+
          '<li class="page"><a data-page="9" href="http://test.dev?page=9">9</a></li>'+
          '<li class="page"><a data-page="10" href="http://test.dev?page=10">10</a></li>'+
          '<li class="page"><a data-page="11" href="http://test.dev?page=11">11</a></li>'+
          '<li class="page selected"><a data-page="12" href="http://test.dev?page=12">12</a></li>'+
          '<li class="page"><a data-page="13" href="http://test.dev?page=13">13</a></li>'+
          '<li class="page"><a data-page="14" href="http://test.dev?page=14">14</a></li>'+
          '<li class="page"><a data-page="15" href="http://test.dev?page=15">15</a></li>'+
          '<li class="page"><a data-page="16" href="http://test.dev?page=16">16</a></li>'+
          '<li class="page"><a data-page="17" href="http://test.dev?page=17">17</a></li>'+
          '<li class="page" style="display:none"><a data-page="18" href="http://test.dev?page=18">18</a></li>'+
          '<li class="page" style="display:none"><a data-page="19" href="http://test.dev?page=19">19</a></li>'+
          '<li class="page" style="display:none"><a data-page="20" href="http://test.dev?page=20">20</a></li>'+
          '<li class="move next "><a data-page="13" href="http://test.dev?page=13" class="next">Next &raquo;</a></li></ul>'
      end
    end

  end
end
