require 'spec_helper'

describe MoviesController do
    describe 'find same director as' do
        before :each do
            @fake_results = [mock('movie1'), mock('movie2')]
        end
        it 'should call to the model to perform the search' do
            Movie.should_receive(:find_same_director_as).with('Star wars').
                and_return([@fake_results])
            get :same_director_as, {:title => 'Star wars'}
        end
        describe 'after valid search' do
            before :each do
                Movie.stub(:find_same_director_as).and_return(@fake_results)
                get :same_director_as, {:title => 'Star wars'}
            end
            it 'should make the results available to that template' do
                assigns(:movies).should == @fake_results
            end
            it 'shoud select the same_director_as template for redering' do
                response.should render_template('same_director_as')
            end
        end
        describe 'after find without results' do
            before :each do
                Movie.stub(:find_same_director_as).and_return(nil)
                get :same_director_as, {:title => 'Star wars'}
            end
            it 'should redirect to the home page' do
                assert_redirected_to '/'
            end
            it "should show the message 'Movie' has no director info" do
                assert_equal "'Star wars' has no director info", flash[:notice]
            end
        end
    end
end