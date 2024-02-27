# frozen_string_literal: true

class EncryptionManager

  def initialize(encryption)
    @encryption_class = encryption
    @storage = {}

  end

  public

  def new_known_key(p, q, e, id)
    item = @encryption_class.new
    item.create(p, q, e)
    @storage[id] = item
    p "New key created with id: #{id}"
  end

  def new_unknown_key(e, n, id)
    item = @encryption_class.new
    item.solve(e, n)
    @storage[id] = item
    p "New key created with id: #{id}"
  end

  def access_key(id)
    @storage[id]
  end

  def verify_keys
    @storage.each do |key, value|
      p "Key: #{key} is #{value.verify_key}"
    end
  end

  def import_keys(data)
    data.each do |key, value|
      item = @encryption_class.new
      item.solve(value[:e], value[:n])
      @storage[key] = item
    end
  end

end
