require 'spec_helper'

describe Movie do
    describe 'find find_same_director_as' do
        before :each do
            @fake_movie = mock('Movie')
            @fake_movie.stub(:director).and_return('George Lucas')
            @fake_movie.stub(:title).and_return('Star wars')
        end
        it 'should call to find method' do
            Movie.should_receive(:find_by_title).with('Star wars').
                and_return(@fake_movie)
            Movie.find_same_director_as('Star wars')
        end
        describe 'after a success search for movie' do
            it 'should call to find_by_director method with the same director of the target movie' do
                Movie.stub(:find_by_title).and_return(@fake_movie)
                Movie.should_receive(:where).with(director: 'George Lucas').
                        and_return([mock('movie1'), mock('movie2')])
                Movie.find_same_director_as('Star wars')
            end
        end
        describe 'after search for a movie without director' do
            it 'should return a empty array' do
                @movie_without_director = mock('Movie')
                @movie_without_director.stub(:title).and_return('Star wars')
                @movie_without_director.stub(:director).and_return(nil)
                Movie.stub(:find_by_title).and_return(@movie_without_director)

                Movie.stub(:where).and_return(@movie_without_director)
                Movie.find_same_director_as('1').should == nil

                @movie_without_director.stub(:director).and_return('')
                Movie.find_same_director_as('1').should == nil
            end
        end
    end
end