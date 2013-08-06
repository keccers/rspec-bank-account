require "rspec"

require_relative "account"

describe Account do

  let(:acct_number)  { "1234567898" }
  let(:account_full)    { Account.new(acct_number, 1000) }  
  let(:account)         { Account.new(acct_number) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account with the given account number and starting balance" do
        expect(account.acct_number).to eq("******7898")
        expect(account.transactions).to eq([0])
        expect(account_full.transactions).to eq([1000])
      end
    end

    context "with invalid input" do
      it "does not create an account with an integer" do
        expect { Account.new(1234567890) }.to raise_error(NoMethodError) #regex can't run on an integer!
      end

      it "does not allow account creation without passing an account number" do
        expect { Account.new }.to raise_error(ArgumentError)
      end

      it "does not allow account creation if the account number is not equal to 10 characters" do
        expect { Account.new("1234") }.to raise_error(InvalidAccountNumberError)
        expect { Account.new("12345678901234") }.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  describe "#transactions" do
    it "should equal 1 after account creation" do
      expect(account_full.transactions.length).to eq(1)
      expect(account.transactions.length).to eq(1)
    end
    it "the first transaction should equal the starting balance" do
      expect(account_full.transactions[0]).to eq(1000)
      expect(account.transactions[0]).to eq(0)
    end
  end

  describe "#balance" do
    it "should equal starting balance after account creation" do
      expect(account.balance).to eq(0)
      expect(account_full.balance).to eq(1000)
    end
    #after initialize balance should equal starting balance 
  end

  describe "#account_number" do
    #the result of the account number method != original account number  
    #the result of the account number method == ********7898
  end

  describe "deposit!" do
    #if deposit is less than 0 get error
    #if deposit is valid balance = balance + deposit
  end

  describe "#withdraw!" do
    #if balance is less than withdraw amt. get error
    #if withdraw is valid balance = balance - withdrawl
  end
end
