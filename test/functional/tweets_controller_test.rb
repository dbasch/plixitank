require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  context 'TweetsController' do
    context 'GET #index for the homepage' do
      setup do
        get :index
      end

      should respond_with :success
      should render_template :index
    end

    context 'GET #index with a query' do
      setup do
        get :index, :q => 'puppy'
      end

      should respond_with :success
      should render_template :index
      should assign_to :docs
    end
  end
end
