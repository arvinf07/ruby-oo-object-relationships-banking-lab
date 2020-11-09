class Transfer
  attr_accessor :amount, :status
  attr_reader :sender, :receiver

  def initialize(sender, receiver, amount, status = 'pending')
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = status
  end  

  def valid?
    sender.valid? && receiver.valid?
  end  

  def execute_transaction
    if @status == 'pending'
      @sender.valid?
      @sender.balance -= @amount
      @receiver.balance += @amount
      if @sender.valid? && @receiver.valid?
        @status = 'complete' 
      else
        @status = 'rejected'   
        "Transaction rejected. Please check your account balance."
      end    
    end  
  end  

  def reverse_transfer
    if @status == 'complete'
      @status = 'reversed'
      @sender.balance += @amount
      @receiver.balance -= @amount
    end  
  end  

end
