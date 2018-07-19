class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
  	@sender = sender
  	@receiver = receiver
  	@amount = amount
  	@status = "pending"
  end

  def valid?
  	self.sender.valid? && self.receiver.valid? && @amount <= self.sender.balance
  end

  def execute_transaction
  	if !self.valid?
  		self.status = "rejected"
  		return "Transaction rejected. Please check your account balance."
  	elsif self.valid?  && self.status == "pending"
  		self.sender.balance -= self.amount
  		self.receiver.balance += self.amount
  		self.status = "complete"
  	else
  		# Do nothing because this has already been executed
  	end	
  end

  def reverse_transfer
  	if self.status == "complete"
  		self.receiver.balance -= self.amount
  		self.sender.balance += self.amount
  		self.status = "reversed"
  	end	
  end
end
