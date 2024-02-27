require_relative 'math_encryption'
require_relative 'encryption_manager'

# Create a new instance of the EncryptionManager class
# and pass in the MathEncryption class as an argument
# to the constructor.
manager = EncryptionManager.new(MathEncryption)
# Create home encryption key
# Group id: 5
manager.new_known_key(224737, 104729, 37813, 5)

# Remaining groups data in hash to be imported into the manager
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

manager.import_keys(data)

# Verify all keys
manager.verify_keys

# Access group 1 key
p manager.access_key(1).get_all_data
