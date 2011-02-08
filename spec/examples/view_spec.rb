require File.dirname(__FILE__) + '/../spec_helper'

describe ViewSomething do

  before(:all) do
    class User < ActiveRecord::Base
    end
  end

  before(:each) do
    User.destroy_all
  end

  it 'should be able to create a view that does not exist' do
    User.create(:name => 'john')
    users = ViewSomething.view User.where('name = "john"')
    users.should_not be_empty
    users.each { |u| u.should be_a(User) }
  end

  it 'should be able to create a view that does not exist, and then use it successfully' do
    users = ViewSomething.view User.where('name = "kate"')
    users.should be_empty
    User.create(:name => 'kate')
    users = ViewSomething.view User.where('name = "kate"')
    users.should_not be_empty
  end

  it 'should be able to create a view of #all' do
    User.create(:name => 'john')
    users = ViewSomething.view User.where('')
    users.size.should == 1
  end

end
