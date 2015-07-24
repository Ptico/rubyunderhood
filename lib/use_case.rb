class UseCase
  attr_reader :errors

  def success?
    @errors.nil?
  end

  def call; end

private

  def initialize(data)
    @data = data
    @errors = nil
  end
end
