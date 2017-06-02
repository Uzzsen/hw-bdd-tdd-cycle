# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	Movie.create(movie) #title: movie["title"], rating: movie["rating"], release_date: movie["release_date"])
  end
#  flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	rating_list.split(/,|\s+/).delete_if {|i| i.empty?}.each do |rating|
	uncheck ? uncheck("ratings_" + rating) : check("ratings_" + rating)
	end
  #flunk "Unimplemented"
end

Then /I should (not )?see movies with ratings: (.*)/ do |should_not, rating|
	rating_list =[]	
		
    if should_not
    rating_list.each do |rting|	
	#debugger    
	page.find('#movies tbody').should have_no_content(/^#{rting}$/)
	end    
    else
        rating_list.each do |rting|	
        page.find('#movies tbody').should have_content(rting)
	end 
    end
end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all('#movies tbody tr')
	if $rows.respond_to? :should
  rows.count.should == Movie.all.count
	else
  assert rows.count == Movie.all.count
	end
  movie_titles = []
  Movie.all.each {|movie| movie_titles << movie.title}	
  movie_titles.all? do |title|
     page.find_by_id('movies').text.include? title 
	end.should be_true
  #flunk "Unimplemented"
end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |arg1, arg2|
  #pending # express the regexp above with the code you wish you had
  m=Movie.find_by_title(arg1).director
  m.should == arg2 
end

