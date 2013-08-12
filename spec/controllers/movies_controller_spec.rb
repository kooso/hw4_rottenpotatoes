require 'spec_helper'

describe MoviesController do 
    describe "find by director" do

        it 'should call the model method to performs the search by director' do
            Movie.should_receive(:find_by_director).with('Almodovar').
                    and_return([])
            get :find_by_director, {:director_name => 'Almodovar'}
        end
        describe 'select correct template' do
            render_views

            it 'should select the index template for rendering' do
                Movie.stub(:find_by_director).and_return([])
                response.should render_template("index")
                get :find_by_director, {:director_name => 'Almodovar'}
            end
        end
    end
end