# Item_Container should wrap the item class
# Should perform all things an Item can do plus
#
# SHould have no concept of how much you need.   Will only respond with how much volume it has
#
# If you try to remove more volume than it has then it shall throw good error
#
# 1. Check Volume
# 2. Remove Volume
# 3. Correct Volume
# 4. Perhapse know more information about the container??
needs 'Standard Libs/Units'
needs 'Kits/KitContents'

require 'date'
require 'time'

class ItemContainer
  include Units
  include KitContents

  attr_reader :item, :args

  CURRENT_VOLUME = 'current_volume'
  DATE_CHANGE = 'date_volume_change'

  def initialize(item, **args)
    @item = item
    @args = args
    add_associations(starting_volume: args.fetch(:starting_volume, nil))
  end

  def show_current_volume
    qty_display(self.current_volume)
  end

  # returns the current volume of item container
  def current_volume
    eval(item.get(CURRENT_VOLUME))
  end

  # Checks if there is enough volume left to use item
  #
  # @param volume [Hash<qty: , units:>]
  # @return [Boolean] true if there is enough
  def enough_volume?(volume)
    # Convert Volume
    volume = volume[:qty] if volume.is_a? Hash
    (current_volume[:qty].to_d - volume.to_d).positive?
  end

  # Removes a set amount of volume from an item container
  #
  # @param volume [Hash< qty: Double, units: String>]
  def remove_volume(volume)
    cv = current_volume
    new_volume = (cv[:qty] - volume[:qty])
    if new_volume.negative?
      raise "Not enough volume in item #{item.id}, current volume: #{cv},"\
            " volume_removed: #{volume}"
    end
    # volume = convert_units(volume, current_volume[:units]) units class method
    adjust_volume(create_qty(qty: new_volume, units: volume[:units]).to_s)
  end

  # Adds a specific volume to a container
  #
  # @param volume [Hash< qty: Double, units: String>]
  def add_volume(volume)
    cv = current_volume
    new_volume = (cv[:qty] + volume[:qty])
    # volume = convert_units(volume, cv[:units])  units class method
    adjust_volume(create_qty(qty: new_volume, units: volume[:units]).to_s)
  end

  # Returns the last time the volume was modified
  #
  # @return [String] a string of the date and time
  def date_last_modified
    item.get(DATE_CHANGE).to_s
  end

  def to_s
    "<b>#{item.sample.name} - #{item}</b>"
  end

  private

  # Ensures that the associations exist as needed
  def adjust_volume(volume)
    item.modify(CURRENT_VOLUME, volume.to_s)
    item.modify(DATE_CHANGE, Time.now.to_s)
  end

  # Ensures that the associations exists as needed
  def add_associations(starting_volume: nil)
    return unless item.get(CURRENT_VOLUME).nil?

    if starting_volume.nil?
      raise 'Must be given initial volume or Item must'\
            ' already have volume associations'
    end

    item.associate(CURRENT_VOLUME, starting_volume.to_s)
    item.associate(DATE_CHANGE, Time.now.to_s)
  end

end

# Kit container, keeps track of things in a kit.  Records number of reactions
# it has and knows what is in the kit as well.
#
class KitContainer < ItemContainer

  KIT_KEY = 'Kit'.freeze
  KIT_CONTENTS = 'Contents'.freeze

  attr_reader :consumables, :components

  # Initilizes class
  #
  # @param item [Item] the kit item
  # @param **args Hash argumenst
  def initialize(item, **args)
    raise "item: #{item} is not a kit" unless kit?(given_item: item)
    super(item, **args)
    get_contents
  end

  # Checks if the kit is indeed a kit
  # TODO should really check "kit" parameter on Sample not item
  #
  # @return [Boolean]
  def kit?(given_item: nil)
    used_item = given_item || @item
    used_item.sample.properties['Kit'].downcase == "true"
  end

  def content_to_s(input_name)
    "#{item}-#{input_name}"
  end

  private

  # gets the contents of a kit and reports it as a hash
  #
  # @return Hash <key: string>
  def get_contents
    sample_name = @item.sample.name
    contents = CONTENTS[sample_name]
    @consumables = contents[:consumables]
    @components = contents[:components]
  end

end