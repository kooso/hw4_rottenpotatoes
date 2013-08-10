Given /^the following movies exist:$/ do |movies_table|
  # table is a Cucumber::Ast::Table
    movies_table.hashes.each do |movie|
        Movie.new(movie).save!
    end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie, director|
    Movie.where(title: movie) do |movie|
        assert movie.director == director
    end
end
