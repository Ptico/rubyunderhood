require 'lib/validation/result'
require 'lib/validation/result_kind'

class Validation

  attr_reader :object, :result

  def validate; end

  def valid?
    @result.valid?
  end

protected

  def add_error(field, message=nil)
    result.add(field, message)
  end

private

  def initialize(object)
    @object = object
    @result = Result.new
    validate
  end
end
