# Kit Parts should wraps the collection class
# Instantiates a collection of some size.
# Each part of the collection represents an Item in the Kit
# This must utilize the functions of ItemContainer to help mediate volumes of each container
#
# If I ask for a certain type of part should return the item that has enough volume
# Can check if the kit as a whole has enough samples left 
# The collection containing the kit parts should be wrapped in ItemContainer to help manage number of things left.
        # Perhapse it should have a sub class KitContainer to handle those things
needs 'Container/ItemContainer'
needs 'Standard Libs/Units'

class KitContainerParts < ItemContainer

  needs CollectionActions
  needs ItemContainer

  COLLECTION_TYPE = 'Kit Collection'

  attr_reader :collection, :parts

  # Args
  #
  # @param starting_reactions [Int]
  def initialize(collection, rxn_required, starting_reactions: nil)
    start_vol = starting_reations.nil? ? starting_reactions : create_volume(qty: starting_reactions, units: 'rxn')
    super(collection, staring_volume: start_vol)
    @collection = collection
    @parts = make_part_containers
    raise 'Not enough reactions' if 
  end

  #checks if there is enough reactions left
  #
  # @param rxns [Int]
  # @return [Boolean]
  def enough_volume(rxns)
    (current_volume[:qty] - rxns).positive?
  end

  # Returns a part of adequate volume if one exists.
  # If no sample exists return nil
  #
  # @param sample_name [String] name of the sample required
  # @param volume_required [Hash<qty: , units: >] the volume required (optional)
  # @Return [ItemContainer || nil]
  def get_part(sample_name:, volume_required: nil)
    parts.each do |part|
      next unless part.item.sample.name.equal? sample_name
      next unless part.enough_volume? volume_required
      return part
    end
    return nil
  end

  private

  # Takes all the parts of the container and wraps them in ItemContainers
  # Creates an array to be used
  #
  # @return [Array<ItemContainer>]
  def make_part_containers
    @kit_collection.parts.map(|part| ItemContainer.new(part))
  end
end
