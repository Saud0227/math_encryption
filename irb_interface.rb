require 'irb'

require_relative 'math_encryption'
require_relative 'encryption_manager'

module IRB
  def self.start_session(binding)
    IRB.setup(nil)

    workspace = WorkSpace.new(binding)

    if @CONF[:SCRIPT]
      irb = Irb.new(workspace, @CONF[:SCRIPT])
    else
      irb = Irb.new(workspace)
    end

    @CONF[:IRB_RC].call(irb.context) if @CONF[:IRB_RC]
    @CONF[:MAIN_CONTEXT] = irb.context

    trap("SIGINT") do
      irb.signal_handle
    end

    catch(:IRB_EXIT) do
      irb.eval_input
    end
  end
end

t = EncryptionManager.new(MathEncryption)

data = {
  1 => { e: 5693,
         n: 58823 },
  2 => { e: 34949,
         n: 988991 },
  3 => { e: 5,
         n: 2561851 },
  4 => { e: 723073327,
         n: 8444684861 },
  6 => { e: 5,
         n: 133921 },
  7 => { e: 199,
         n: 287799 },
  8 => { e: 7793,
         n: 34612009 },
  9 => { e: 11,
         n: 38191 },
  10 => { e: 15242609,
          n: 16487657 },
  11 => { e: 5,
          n: 36617393 },
  12 => { e: 3,
          n: 12312757 },
  13 => { e: 1136411,
          n: 1293703 },
  14 => { e: 3,
          n: 62615533 },
}
t.new_known_key(224737, 104729, 37813, 5)
t.import_keys(data)
t.verify_keys

IRB.start_session(Kernel.binding)