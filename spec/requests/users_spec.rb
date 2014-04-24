require 'spec_helper'

describe "Users" do
  before do
	@user = User.new(name: "Exemple User", email: "user@exemple.come")
  end
  subject {@user}
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should be_valid }
 
  describe "when name is not present" do
    before { @user.name= " " }
    it { should_not  be_valid }
  end

  describe "when name is too long" do
      before { @user.name = "a" * 51 }
      it { should_not be_valid }
  end
end
