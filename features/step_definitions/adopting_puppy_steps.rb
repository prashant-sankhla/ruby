def row_for(line_item)
  (line_item - 1) * 6
end

def cart_line_item(line_item)
  @browser.table(:index => 0)[row_for(line_item)]
end


Given(/^I am on the puppy adoption site$/) do
  @browser.goto "http://puppies.herokuapp.com"
end

When(/^I click the first View Details button$/) do
  @browser.button(:value => 'View Details', :index=>0).click
end

When(/^I click the second View Details button$/) do
  @browser.button(:value => 'View Details', :index=>1).click
end

When(/^I click the Adopt Me button$/) do
  @browser.button(:value => 'Adopt Me!').click
end


When(/^I click the Adopt Another Puppy button$/) do
  @browser.button(:value => 'Adopt Another Puppy').click
end

When(/^I click the Complete the Adoption button$/) do
  @browser.button(:value => 'Complete the Adoption').click
end

When(/^I enter "(.*?)" in the name field$/) do |name|
  @browser.text_field(:id => 'order_name').set(name)
end

When(/^I enter "(.*?)" in the address field$/) do |arg1|
  @browser.text_field(:id => 'order_address').set(arg1)
end

When(/^I enter "(.*?)" in the email field$/) do |arg1|
  @browser.text_field(:id => 'order_email').set(arg1)
end

When(/^I select "(.*?)" from the pay with dropdown$/) do |arg1|
  @browser.select_list(:id => 'order_pay_type').select(arg1)
end

When(/^I click the Place Order button$/) do
  @browser.button(:value => 'Place Order').click
end

Then(/^I should see "(.*?)"$/) do |expected|
  #fail 'Browser text did not match expected value' unless @browser.text.include? arg1
  expect(@browser.text).to include expected
end

Then(/^I should see "(.*?)" as the name for line item (\d+)$/) do |name, line_item|
  row = row_for(line_item.to_i)
  expect(cart_line_item(line_item.to_i)[1].text).to include name
end

Then(/^I should see "(.*?)" as the subtotal for line item (\d+)$/) do |subtotal, line_item|
  row = row_for(line_item.to_i)
  expect(cart_line_item(line_item.to_i)[3].text).to eql subtotal
end

Then(/^I should see "(.*?)" as the cart total$/) do |total|
  expect(@browser.td(:class => 'total_cell').text).to eql total
end


