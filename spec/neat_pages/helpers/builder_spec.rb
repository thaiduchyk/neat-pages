require 'spec_helper'

describe NeatPages::Helpers::Builder do
  include ViewHelpers

  describe "#b" do
    context "with an empty builder" do
      let(:builder) { NeatPages::Helpers::Builder.new(double, request_mock) }

      context "when inserting the string <span>1</span>" do
        subject { builder.b '<span>1</span>' }

        it { should eql '<span>1</span>' }
        it { should be_html_safe }

        context "and inserting another <span>2</span>" do
          before { builder.b '<span>1</span>' }

          subject { builder.b '<span>2</span>' }

          it { should eql '<span>1</span><span>2</span>' }
        end
      end
    end
  end

  describe "#li" do
    context "with an empty builder" do
      let(:builder) { NeatPages::Helpers::Builder.new(double, request_mock) }

      context "when inserting a li with the value 1" do
        before { builder.li '1' }

        specify { builder.b.should eql '<li>1</li>' }
      end

      context "when inserting an hidden li with the value 1, the css_class 'active'" do
        before { builder.li '1', 'active', hidden: true }

        specify { builder.b.should eql '<li class="active" style="display:none">1</li>' }
      end

    end
  end

  describe "#path_to" do
    context "with a builder having a base_url http://www.test.dev" do

      context "and no params" do
        let(:builder) { NeatPages::Helpers::Builder.new(double, request_mock(host: 'www.test.dev')) }

        context "when asking for the path_to page 6" do
          specify { builder.path_to(6).should eql 'http://www.test.dev?page=6' }
        end
      end

      context "and the params sort=1, filter=type" do
        let(:request) { request_mock(host: 'www.test.dev', env: { 'action_dispatch.request.query_parameters' => { 'sort' => 1, 'filter' => 'type' } })}
        let(:builder) { NeatPages::Helpers::Builder.new(double, request) }

        context "when asking for the path_to page 6" do
          specify { builder.path_to(6).should eql 'http://www.test.dev?filter=type&page=6&sort=1' }
        end
      end

      context "and the params sort=1, filter=type, page=5" do
        let(:request) { request_mock(host: 'www.test.dev', env: { 'action_dispatch.request.query_parameters' => { 'sort' => 1, 'filter' => 'type', 'page' => 5 } })}
        let(:builder) { NeatPages::Helpers::Builder.new(double, request) }

        context "when asking for the path_to page 6" do
          specify { builder.path_to(6).should eql 'http://www.test.dev?filter=type&page=6&sort=1' }
        end
      end

      context "and the params tags=['foo', 'bar'], page=5" do
        let(:request) { request_mock(host: 'www.test.dev', env: { 'action_dispatch.request.query_parameters' => { 'page' => 5, 'tags' => ['foo', 'bar'] } })}
        let(:builder) { NeatPages::Helpers::Builder.new(double, request) }

        context "when asking for the path_to page 6" do
          specify { builder.path_to(6).should eql 'http://www.test.dev?page=6&tags%5B%5D=foo&tags%5B%5D=bar' }
        end
      end

      context "and the params filters[foo]= 1, filters[bar] = 2, page=5" do
        let(:request) { request_mock(host: 'www.test.dev', env: { 'action_dispatch.request.query_parameters' => { 'page' => 5, 'filters' => { 'foo' => '1', 'bar' => '2' } } })}
        let(:builder) { NeatPages::Helpers::Builder.new(double, request) }

        context "when asking for the path_to page 6" do
          specify { builder.path_to(6).should eql 'http://www.test.dev?filters%5Bbar%5D=2&filters%5Bfoo%5D=1&page=6' }
        end
      end

      context "and the params page=5" do
        let(:request) { request_mock(host: 'www.test.dev', env: { 'action_dispatch.request.query_parameters' => { 'page' => 5 } })}
        let(:builder) { NeatPages::Helpers::Builder.new(double, request) }

        context "when asking for the path_to page 6" do
          specify { builder.path_to(6).should eql 'http://www.test.dev?page=6' }
        end
      end
    end
  end

  describe "#reset_builder" do
    context "with an empty builder" do
      let(:builder) { NeatPages::Helpers::Builder.new(double, request_mock) }

      context "when resetting the builder" do
        before { builder.reset_builder }

        specify { builder.b.should eql '' }
      end
    end

    context "with a builder having the value '<span>1</span>'" do
      let(:builder) { NeatPages::Helpers::Builder.new(double, request_mock) }

      before { builder.b '<span>1</span>' }

      context "when resetting the builder" do
        before { builder.reset_builder }

        specify { builder.b.should eql '' }
      end
    end
  end
end
