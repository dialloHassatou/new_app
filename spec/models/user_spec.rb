require 'spec_helper'

describe "User" do
  before do
	@user = User.new(name: "Exemple User1", email: "user2@exemple.com", password: "foobar2", password_confirmation: "foobar2")
  end
  subject {@user}
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should be_valid }
 
  describe "when name is not present" do
    before { @user.name= " " }
    it { should_not  be_valid }
  end

  describe "when name is too long" do
      before { @user.name = "a" * 51 }
      it { should_not be_valid }
  end
   
  describe "when email is not present" do
    before { @user.email= " " }
    it { should_not  be_valid }
  end

  describe "when email format is invalid" do
      it "should be invalid" do
	adresses = %w[user@foo,com user_at_foo.org exemple.user@foo.
			foo@bar_baz.com foo@bar+baz.com]
	adresses.each do |invalid_adress|
	  @user.email =invalid_adress
	  @user.should_not be_valid
        end
      end
  end
  describe "when email format is valid" do
      it "should be invalid" do
	adresses = %w[user@foo.COM A_US_ER@f.b.org  frst.lst@foo.jp a+b@baz.cn]
	adresses.each do |valid_adress|
	  @user.email =valid_adress
	  @user.should be_valid
        end
      end
  end
  describe "when email adress is already taken" do
    before do
	user_with_same_email = User.new(name: "Exemple User1", email: "user2@exemple.com", password: "foobar2", password_confirmation: "foobar2")
	user_with_same_email.save
    end
	
    it { should_not be_valid }
  end

  describe "when password is not present" do 
    before {@user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end 
 
  describe "when password doesn't match confirmation" do 
    before {@user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end 

  describe "when password  confirmation is nil " do 
    before {@user.password_confirmation = nil}
    it { should_not be_valid }
  end 
describe "return value of authenticate method " do 
    before do 
    @user = User.new( name:"hasso5", email:"exemple5@exmple.com", password: "foobar5", password_confirmation: "foobar5" )
    @user.save
    end
    let(:found_user)   {User.find_by_email(@user.email) }

    describe "when valid password   " do 
    it { should == found_user.authenticate(@user.password) }
    end 
    describe "when invalid password   " do 
    let(:user_for_invalid_password) {found_user.authenticate("invalid") }
    it { should_not == user_for_invalid_password }
    specify {user_for_invalid_password.should be_false }
    end 
end
     
   describe "with a password that's too short" do 
    before {@user.password = @user.password_confirmation = "a" * 5}
    it {should be_invalid }
  
  end 




end
 

  

  

