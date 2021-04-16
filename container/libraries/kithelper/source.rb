
module KitHelper

  # Returns a kit with enough reactions left to be used
  # TODO Add portion to grab oldest kit (or newest) or more complex
  #      algorithm to figure out best kit to use
  #
  # @param sample_type_name [String] the sample name of the desired kit
  def find_kit(sample_type_name, volume)
    sample = Sample.find_by_name(sample_type_name)

    possible_items = Item.where(sample: sample).reject(&:deleted?)

    possible_kits = possible_items.sort! do |ite|
      raise "#{ite.id.to_s} has no association 'current_volume'" unless ite.get('current_volume').present?

      eval(ite.get('current_volume'))[:qty]
    end
    possible_kits.each do |kit|
      kit_cont = KitContainer.new(kit)
      return kit_cont if kit_cont.enough_volume?(volume)
    end
    raise "No kits of type <b>#{sample_type_name}</b> with sufficient volume"
  end

end