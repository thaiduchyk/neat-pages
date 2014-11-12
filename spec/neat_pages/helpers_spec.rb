require 'spec_helper'

describe NeatPages::Helpers do
  include ViewHelpers

  let(:pagination) { double() }
  let(:views) { Module.new { extend NeatPages::Helpers } }

  describe "#neat_pages_ajax_items" do
    before { views.stub(:render).and_return '[html_list_of_items]' }

    specify "when rendering the ajax items" do
      expect(views.neat_pages_ajax_items('items')).to eql '<div id="neat-pages-ajax-wrapper" class="first-load">[html_list_of_items]</div>'
    end

    specify "when rendering the ajax items for a table" do
      expect(views.neat_pages_ajax_items('items', wrapper: 'tbody')).to eql '<tbody id="neat-pages-ajax-wrapper" class="first-load">[html_list_of_items]</tbody>'
    end
  end

  describe "#neat_pages_more_button" do
    before do
      views.stub(:request).and_return(request_mock(host: 'testview.dev'))

      pagination.stub(:paginated?).and_return(true)
      pagination.stub(:next?).and_return(true)
      pagination.stub(:next_page).and_return(2)
      pagination.stub(:total_pages).and_return(4)

      views.stub(:pagination).and_return(pagination)
    end

    specify "when rendering the more button" do
      expect(views.neat_pages_more_button).to eql '<div id="neat-pages-more-button" data-next-page="2" data-total-pages="4">' +
        '<a href="http://testview.dev?page=2">More items</a><div class="over">No more items</div></div>'
    end
  end

  describe "#neat_pages_navigation" do
    before do
      views.stub(:request).and_return(request_mock(host: 'testview.dev'))

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

      views.stub(:pagination).and_return(pagination)
    end

    specify "when rendering the navigation" do
      expect(views.neat_pages_navigation).to eql '<ul class="standard" id="neat-pages-navigation" data-neat-pages-control=="navigation" data-per-page="10" data-total-items="40" data-total-pages="4">' +
        '<li class="move previous "><a data-page="2" href="http://testview.dev?page=2" class="previous">&laquo; Previous</a></li>' +
        '<li class="page"><a data-page="1" href="http://testview.dev?page=1">1</a></li>' +
        '<li class="page"><a data-page="2" href="http://testview.dev?page=2">2</a></li>' +
        '<li class="page selected"><a data-page="3" href="http://testview.dev?page=3">3</a></li>' +
        '<li class="page"><a data-page="4" href="http://testview.dev?page=4">4</a></li>' +
        '<li class="move next "><a data-page="4" href="http://testview.dev?page=4" class="next">Next &raquo;</a></li></ul>'
    end
  end

  describe "#neat_pages_link_relation_tags" do
    before do
      views.stub(:request).and_return(request_mock(host: 'testview.dev'))

      pagination.stub(:paginated?).and_return(true)
      pagination.stub(:current_page).and_return(3)
      pagination.stub(:next?).and_return(true)
      pagination.stub(:next_page).and_return(4)
      pagination.stub(:previous?).and_return(true)
      pagination.stub(:previous_page).and_return(2)
      pagination.stub(:total_pages).and_return(4)

      views.stub(:pagination).and_return(pagination)
    end

    specify "when rendering the relations" do
      expect(views.neat_pages_link_relation_tags).to eql "<link rel=\"prev\" href=\"http://testview.dev?page=2\"/>\n<link rel=\"next\" href=\"http://testview.dev?page=4\"/>\n"
    end
  end

  describe "#neat_pages_status" do
    before do
      views.stub(:request).and_return(request_mock)

      pagination.stub(:empty?).and_return(false)
      pagination.stub(:out_of_bound?).and_return(false)
      pagination.stub(:offset).and_return(20)
      pagination.stub(:per_page).and_return(10)
      pagination.stub(:total_items).and_return(100)

      views.stub(:pagination).and_return(pagination)
    end

    specify "when rendering the status" do
      expect(views.neat_pages_status).to eql '<span data-neat-pages-control="status" id="neat-pages-status"><span class="from">21</span> to <span class="to">30</span>/<span class="total">100</span></span>'
    end
  end
end
