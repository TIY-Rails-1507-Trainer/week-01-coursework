require_relative 'account'
require_relative 'bank'


current_account = Account.new(100)
savings_account = Account.new(500)
user_bank = Bank.new(current_account, savings_account)

def continue_using_services?
	print "\nWould you like another service? "
	response = gets.chomp.downcase
	response == "y" || response == "yes"
end

def display_balance(current_account, savings_account)
	puts "Your current account has #{current_account.balance}."
	puts "Your savings account has #{savings_account.balance}.\n"
end	

begin
	print "\nHi, which services would you like to use? \n View \e[#{4}mBalance\e[#{0}m \n \e[#{4}mDeposit\e[#{0}m Funds \n \e[#{4}mWithdraw\e[#{0}m Funds \n \e[#{4}mTransfer\e[#{0}m Funds \n \e[#{4}mExit\e[#{0}m\n\n"
	answer = gets.chomp.downcase

	if answer == "balance"
		display_balance(current_account, savings_account)
		
 	elsif answer == "deposit"
		print "\nHow much would you like to deposit in your current account? "
			dep = gets.chomp.to_i
			current_account.deposit(dep)
		puts "\nYour new balance is #{current_account.balance}."
		

	elsif answer == "withdraw"
		print "\nHow much would you like to withdraw from your current account? "
			wit = gets.chomp.to_i
				if wit > current_account.balance
					puts "You cannot withdraw more than your current balance."
				else current_account.withdraw(wit)
					puts "\nYour new balance is #{current_account.balance}."
				end
		

	elsif answer == "transfer"
			print "\nWhich account would you like to transfer \e[#{1}mfrom\e[#{0}m? Your \e[#{4}mcurrent\e[#{0}m or \e[#{4}msavings\e[#{0}m?\n\n"
			a3 = gets.chomp.downcase
			if a3 == "current"
				print "\nHow much to transfer? "
				trans_amount = gets.chomp.to_i
					if trans_amount > current_account.balance
						puts "You cannot transfer more than your balance."
					else user_bank.transfer(current_account, savings_account, trans_amount)
						puts "\nYour current account now has #{current_account.balance}.\nYour savings account now has #{savings_account.balance}.\n"
					end
					
			elsif a3 == "savings"
			 	print "\nHow much to transfer? "
				trans_amount = gets.chomp.to_i
					if trans_amount > savings_account.balance
						puts "You cannot transfer more than your balance."
					else user_bank.transfer(savings_account, current_account, trans_amount)
						puts "\nYour current account now has #{current_account.balance}.\nYour savings account now has #{savings_account.balance}.\n"
					end
					
			else puts "\nPlease enter a valid account name."
			end


	elsif answer == "exit"
		break
		
	else puts "\nValid commands include Balance, Deposit, Withdraw, Transfer, Exit. Please try again. \n"
	end
end while( continue_using_services? )

puts "\nThank you. Goodbye."
