class Validation
  class ResultKind
    attr_reader :errors, :fields, :orphans

    def valid?
      false
    end

  private

    def initialize(message)
      @errors  = Hash.new { |h, k| h[k] = Set[] }
      @orphans = Set[message]
      @fields  = Set[]
    end
  end
end
