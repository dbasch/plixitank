require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  context 'TweetsController' do
    context 'GET #index' do
      setup do
        get :index
      end

      should respond_with :success
      should render_template :index
    end
  end
end
