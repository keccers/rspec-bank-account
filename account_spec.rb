require "rspec"

require_relative "account"

describe Account do

  let(:acct_number)  { "1234567898" }
  let(:account_full)    { Account.new(acct_number, 1000) }  
  let(:account)         { Account.new(acct_number) }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Account with an account number and starting balance" do
        expect(account.acct_number).to_not eq(nil)
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
    it "should equal sum of transactions" do
      account.stub(transactions: [1,2,3,4,5])
      expect(account.balance).to eq(15)
    end
  end

  describe "#account_number" do
    it "returns an obfuscated version of the original account number" do
      expect(account.acct_number).to eq("******7898")
    end

    it "does not return the original number" do
      expect(account.acct_number).to_not eq("1234567898")
    end
  end

  describe "deposit!" do
    it "a valid deposit adds the deposit value to the transactions array" do
      account.stub(transactions: [1,2,3,4])
      account.deposit!(100)
      expect(account.transactions).to eq([1,2,3,4,100])
    end

    it "returns an error if the deposit amount is less than zero" do
      expect{ account.deposit!(-100) }.to raise_error(NegativeDepositError)
    end
  end

  describe "#withdraw!" do
    it "a valid withdrawl adds the negative withdrawl value to the transactions array" do
      account.stub(transactions: [1000,2,3,4])
      account.withdraw!(100)
      expect(account.transactions).to eq([1000,2,3,4,-100])
    end

    it "a withdrawl cannot be completed if the balance is less than the withdraw amount" do
      account.stub(transactions: [1,2,3,4])
      expect{ account.withdraw!(100) }.to raise_error(OverdraftError)
    end
  end
end
