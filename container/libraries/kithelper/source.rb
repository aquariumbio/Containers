
module KitHelper

  # Returns a kit with enough reactions left to be used
  # TODO Add portion to grab oldest kit (or newest) or more complex
  #      algorithm to figure out best kit to use
  #
  # @param sample_type_name [String] the sample name of the desired kit
  def find_kit(sample_type_name, volume)
    sample = Sample.find_by_name(sample_type_name)

    possible_kits = Item.where(sample: sample).to_a.sort!{ |ite|
      ite.current_volume[:qty]
    }
    possible_kits.each do |kit|
      kit_cont = KitContainer.new(kit)
      return kit_cont if kit_cont.enough_volume?(volume)
    end
  end

end